-module(solution).
-export([find_non_min_max/1]).

find_non_min_max(Nums) when length(Nums) < 3 ->
    -1;
find_non_min_max(Nums) ->
    Min = lists:min(Nums),
    Max = lists:max(Nums),
    [Result | _] = lists:filter(fun(X) -> X =/= Min andalso X =/= Max end, Nums),
    Result.