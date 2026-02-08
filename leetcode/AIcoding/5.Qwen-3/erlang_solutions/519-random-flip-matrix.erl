-module(rfm).
-export([new/2, flip/1]).

-record(state, {m, n, total, used}).

new(M, N) ->
    #state{m = M, n = N, total = M * N, used = sets:new()}.

flip(State) ->
    Rand = rand:uniform(State#state.total),
    case sets:is_element(Rand, State#state.used) of
        true ->
            flip(State);
        false ->
            NewUsed = sets:add_element(Rand, State#state.used),
            Row = (Rand - 1) div State#state.n,
            Col = (Rand - 1) rem State#state.n,
            {Row, Col}
    end.