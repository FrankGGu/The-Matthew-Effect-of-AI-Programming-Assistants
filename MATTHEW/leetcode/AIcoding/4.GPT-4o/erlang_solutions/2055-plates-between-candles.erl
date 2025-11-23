-module(solution).
-export([plates_between_candles/3]).

plates_between_candles(N, S, queries) ->
    Candles = find_candles(S, N),
    Plates = count_plates(S, Candles),
    lists:map(fun({L, R}) -> Plates[R + 1] - Plates[L] end, queries).

find_candles(S, N) ->
    lists:foldl(fun(X, {Idx, Acc}) ->
        case X of
            $| -> {Idx + 1, [Idx | Acc]};
            _ -> {Idx + 1, Acc}
        end
    end, {0, []}, S).

count_plates(S, Candles) ->
    Plates = lists:map(fun(X) -> if X == $* -> 1; true -> 0 end end, S),
    lists:foldl(fun(X, Acc) -> Acc ++ [lists:last(Acc) + X] end, [0], Plates).