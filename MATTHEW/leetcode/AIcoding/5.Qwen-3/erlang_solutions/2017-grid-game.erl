-module(grid_game).
-export([gridGame/1]).

gridGame(Grid) ->
    Rows = length(Grid),
    Cols = length(hd(Grid)),
    [R1, R2] = Grid,
    {Sum1, Sum2} = {lists:sum(R1), lists:sum(R2)},
    Min = min(Sum1, Sum2),
    Max = max(Sum1, Sum2),
    case Cols of
        1 -> 0;
        _ -> 
            lists:foldl(fun(I, Acc) ->
                NewSum1 = Sum1 - lists:nth(I, R1),
                NewSum2 = Sum2 - lists:nth(I, R2),
                case I of
                    1 -> Acc;
                    _ -> 
                        if
                            NewSum1 < NewSum2 -> Acc + NewSum1;
                            true -> Acc + NewSum2
                        end
                end
            end, 0, lists:seq(1, Cols))
    end.