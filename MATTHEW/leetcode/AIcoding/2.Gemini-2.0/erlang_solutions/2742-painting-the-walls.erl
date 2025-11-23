-module(painting_walls).
-export([paint_walls/1]).

paint_walls(Cost) ->
    N = length(Cost),
    lists:foldl(fun(C, DP) ->
                        lists:map(fun(J) ->
                                          min(J, C + lists:nth(J - C, DP))
                                  end, lists:seq(1, N))
                end, lists:seq(0, N - 1), Cost).