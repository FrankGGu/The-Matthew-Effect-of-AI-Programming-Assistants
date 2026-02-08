-module(mk_average).
-export([MkAverage/3, add/2, calculate/1]).

-record(state, {m, k, nums = [], total = 0, valid_count = 0, window = []}).

MkAverage(M, K) ->
    State = #state{m = M, k = K},
    fun
        add(X) -> add(X, State);
        calculate() -> calculate(State)
    end.

add(X, State) ->
    NewTotal = State#state.total + X,
    NewCount = State#state.valid_count + 1,
    NewWindow = lists:append(State#state.window, [X]),
    NewWindowFiltered = lists:sort(NewWindow),
    if
        NewCount > State#m ->
            {M, K} = {State#m, State#state.k},
            Trimmed = lists:sublist(NewWindowFiltered, K),
            TrimmedTotal = lists:sum(Trimmed),
            NewAvg = TrimmedTotal div K,
            NewState = State#state{total = NewTotal, valid_count = NewCount, window = NewWindowFiltered},
            {NewAvg, NewState};
        true ->
            NewState = State#state{total = NewTotal, valid_count = NewCount, window = NewWindowFiltered},
            {undefined, NewState}
    end.

calculate(State) ->
    lists:sum(State#state.window) div State#state.valid_count.