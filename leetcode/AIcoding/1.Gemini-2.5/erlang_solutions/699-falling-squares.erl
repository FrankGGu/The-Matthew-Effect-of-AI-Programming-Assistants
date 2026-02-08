-module(solution).
-export([falling_squares/1]).

falling_squares(Squares) ->
    process_squares(Squares, [], 0, []).

process_squares([], _FallenSquares, _CurrentMaxHeight, AccResult) ->
    lists:reverse(AccResult);
process_squares([[L, S] | Rest], FallenSquares, CurrentMaxHeight, AccResult) ->
    R = L + S,
    BaseHeight = find_base_height(L, R, FallenSquares),
    NewHeight = BaseHeight + S,
    NewFallenSquares = [{L, R, NewHeight} | FallenSquares],
    NewCurrentMaxHeight = max(CurrentMaxHeight, NewHeight),
    process_squares(Rest, NewFallenSquares, NewCurrentMaxHeight, [NewCurrentMaxHeight | AccResult]).

find_base_height(L, R, FallenSquares) ->
    lists:foldl(fun({PrevL, PrevR, PrevH}, MaxH) ->
                    if
                        L < PrevR andalso R > PrevL -> max(MaxH, PrevH);
                        true -> MaxH
                    end
                end, 0, FallenSquares).