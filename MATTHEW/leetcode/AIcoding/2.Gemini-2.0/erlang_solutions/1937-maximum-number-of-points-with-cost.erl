-module(maximum_points).
-export([maxPoints/1]).

maxPoints(Points) ->
    maxPoints_helper(Points, 0, 0).

maxPoints_helper([], _, Max) ->
    Max;
maxPoints_helper([Row|Rest], PrevRow, Max) ->
    N = length(Row),
    RowPoints = lists:seq(1, N),
    RowWithIndex = lists:zip(Row, RowPoints),

    NewRow =
        case PrevRow of
            0 -> Row;
            _ ->
                PrevRowMax = lists:max(PrevRow),
                lists:map(fun({Val, Index}) ->
                    MaxVal = lists:max(lists:zipwith(fun(PrevVal, PrevIndex, Ind) ->
                        PrevVal - abs(Ind - Index)
                    end, PrevRow, lists:seq(1, length(PrevRow)), lists:seq(1, length(PrevRow)))),
                    Val + MaxVal
                end, RowWithIndex)
        end,

    maxPoints_helper(Rest, NewRow, 0).