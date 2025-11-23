-module(gas_station).
-export([can_complete_circuit/2]).

can_complete_circuit(Gas, Cost) ->
    N = length(Gas),
    Total = lists:foldl(fun(G, C) -> G + C end, 0, lists:zip(Gas, Cost)),
    if
        Total < 0 -> -1;
        true ->
            Start = 0,
            Current = 0,
            lists:foldl(fun({G, C}, {S, Cur}) ->
                            NewCur = Cur + G - C,
                            if
                                NewCur < 0 -> {S + 1, 0};
                                true -> {S, NewCur}
                            end
                        end, {Start, Current}, lists:zip(Gas, Cost))
    end.