-module(solution).
-export([max_sum_hourglass/1]).

max_sum_hourglass(Grid) ->
    MaxSum = lists:foldl(fun(Row, Acc) ->
        lists:foldl(fun({X, Y}, MaxAcc) ->
            case valid_hourglass(Grid, X, Y) of
                {ok, Sum} -> lists:max([Sum, MaxAcc]);
                error -> MaxAcc
            end
        end, Acc, lists:zip([0, 1, 2], lists:seq(0, length(Grid) - 1)))
    end, -1, lists:seq(0, length(Grid) - 1)),
    MaxSum.

valid_hourglass(Grid, X, Y) ->
    Rows = length(Grid),
    Cols = length(hd(Grid)),
    if
        X + 2 < Rows andalso Y + 2 < Cols ->
            Sum = Grid[X][Y] + Grid[X][Y+1] + Grid[X][Y+2] +
                  Grid[X+1][Y+1] +
                  Grid[X+2][Y] + Grid[X+2][Y+1] + Grid[X+2][Y+2],
            {ok, Sum};
        true ->
            error
    end.