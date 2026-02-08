-module(solution).
-export([min_swaps_couples/1]).

min_swaps_couples(Pairs) ->
    N = length(Pairs),
    Couples = lists:map(fun(X) -> {element(1, X), element(2, X)} end, Pairs),
    Positions = lists:map(fun(X) -> {X, lists:nth(X + 1, Couples)} end, lists:seq(0, N - 1)),
    min_swaps(Positions, 0).

min_swaps(Positions, Swaps) ->
    case lists:all(fun({P1, {P2, P1}}) -> true; _ -> false end, Positions) of
        true -> Swaps;
        false -> 
            NewPositions = lists:map(fun({X, {Y, Z}}) -> 
                if 
                    Y =:= X -> {Y, {Z, Y}}; 
                    true -> {Y, {Z, Y}} 
                end 
            end, Positions),
            min_swaps(NewPositions, Swaps + 1)
    end.