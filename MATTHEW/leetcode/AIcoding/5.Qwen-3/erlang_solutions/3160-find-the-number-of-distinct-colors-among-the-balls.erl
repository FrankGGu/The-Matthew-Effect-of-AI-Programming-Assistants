-module(solution).
-export([num_distinct_colors/1]).

num_distinct_colors(Balls) ->
    Sets = lists:map(fun(Ball) -> sets:from_list(Ball) end, Balls),
    AllColors = lists:foldl(fun(Set, Acc) -> sets:union(Set, Acc) end, sets:new(), Sets),
    sets:size(AllColors).