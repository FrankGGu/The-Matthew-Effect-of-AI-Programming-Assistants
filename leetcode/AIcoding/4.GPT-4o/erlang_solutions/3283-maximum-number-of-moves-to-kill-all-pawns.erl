-module(solution).
-export([maxMoves/1]).

maxMoves(Board) ->
    Rows = length(Board),
    Columns = length(hd(Board)),
    MaxMoves = lists:foldl(fun(R, Acc) ->
        lists:foldl(fun(C, InnerAcc) ->
            case lists:nth(C, R) of
                'P' -> InnerAcc + (Columns - C);
                _ -> InnerAcc
            end
        end, Acc, lists:seq(1, Columns))
    end, 0, lists:seq(1, Rows)),
    MaxMoves.