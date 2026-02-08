-module(solution).
-export([prison_after_n_days/2]).

prison_after_n_days(Cells, N) ->
    Initial = list_to_tuple(Cells),
    States = #{},
    {FinalState, _} = simulate(Initial, N, States),
    tuple_to_list(FinalState).

simulate(State, 0, _States) ->
    {State, 0};
simulate(State, N, States) ->
    case maps:get(State, States, undefined) of
        undefined ->
            NextState = next_state(State),
            NewStates = maps:put(State, NextState, States),
            simulate(NextState, N - 1, NewStates);
        NextState ->
            CycleLength = cycle_length(NextState, States, 1),
            Remaining = N rem CycleLength,
            FinalState = iterate(NextState, Remaining, States),
            {FinalState, CycleLength}
    end.

next_state(State) ->
    Size = tuple_size(State),
    Next = erlang:make_tuple(Size, 0),
    lists:foldl(
        fun(I, Acc) ->
            case I == 0 orelse I == Size - 1 of
                true ->
                    setelement(I + 1, Acc, 0);
                false ->
                    Prev = element(I, State),
                    Next = element(I + 2, State),
                    setelement(I + 1, Acc, if Prev == Next -> 1; true -> 0 end)
            end
        end,
        Next,
        lists:seq(0, Size - 1)
    ).

cycle_length(State, States, Length) ->
    NextState = maps:get(State, States),
    case NextState of
        State -> Length;
        _ -> cycle_length(NextState, States, Length + 1)
    end.

iterate(State, 0, _States) ->
    State;
iterate(State, N, States) ->
    NextState = maps:get(State, States),
    iterate(NextState, N - 1, States).