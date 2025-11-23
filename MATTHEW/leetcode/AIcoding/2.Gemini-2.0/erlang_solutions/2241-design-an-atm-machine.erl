-module(atm).
-export([start/0, withdraw/1, deposit/1]).

-record(state, {
    denominations = [20, 50, 100, 200, 500],
    counts = #{20 => 0, 50 => 0, 100 => 0, 200 => 0, 500 => 0}
}).

start() ->
    process_flag(trap_exit, true),
    State = #state{},
    loop(State).

deposit(Bills) ->
    self() ! {deposit, Bills},
    receive
        {reply, Reply} -> Reply
    end.

withdraw(Amount) ->
    self() ! {withdraw, Amount},
    receive
        {reply, Reply} -> Reply
    end.

loop(State) ->
    receive
        {deposit, Bills} ->
            NewState = deposit_bills(State, Bills),
            self() ! {reply, ok},
            loop(NewState);
        {withdraw, Amount} ->
            {Result, NewState} = withdraw_amount(State, Amount),
            self() ! {reply, Result},
            loop(NewState);
        _ ->
            loop(State)
    end.

deposit_bills(State, Bills) ->
    NewCounts = lists:foldl(
        fun({Denomination, Count}, Acc) ->
            maps:update_with(Denomination, fun(OldCount) -> OldCount + Count end, Count, Acc)
        end,
        State#state.counts,
        Bills
    ),
    State#state{counts = NewCounts}.

withdraw_amount(State, Amount) ->
    Counts = State#state.counts,
    Denominations = State#state.denominations,
    Result = withdraw_amount_helper(Amount, Denominations, Counts, []),
    case Result of
        error ->
            {[], State};
        Bills ->
            NewCounts = lists:foldl(
                fun({Denomination, Count}, Acc) ->
                    maps:update_with(Denomination, fun(OldCount) -> OldCount - Count end, -Count, Acc)
                end,
                Counts,
                Bills
            ),
            {Bills, State#state{counts = NewCounts}}
    end.

withdraw_amount_helper(0, _, _, Acc) ->
    lists:reverse(Acc);
withdraw_amount_helper(_Amount, [], _, _) ->
    error;
withdraw_amount_helper(Amount, [Denomination | Rest], Counts, Acc) ->
    Available = maps:get(Denomination, Counts, 0),
    if
        Available > 0 ->
            MaxBills = min(Amount div Denomination, Available);
            find_solution(Amount, Denomination, MaxBills, Rest, Counts, Acc);
        true ->
            withdraw_amount_helper(Amount, Rest, Counts, Acc)
    end.

find_solution(_Amount, _Denomination, 0, Rest, Counts, Acc) ->
    withdraw_amount_helper(_Amount, Rest, Counts, Acc);
find_solution(_Amount, _Denomination, _MaxBills, _Rest, _Counts, _Acc) when _MaxBills < 0 ->
    error;
find_solution(Amount, Denomination, MaxBills, Rest, Counts, Acc) ->
    NewAmount = Amount - (Denomination * MaxBills);
    case withdraw_amount_helper(NewAmount, Rest, Counts, [{Denomination, MaxBills} | Acc]) of
        error ->
            find_solution(Amount, Denomination, MaxBills - 1, Rest, Counts, Acc);
        Solution ->
            Solution
    end.