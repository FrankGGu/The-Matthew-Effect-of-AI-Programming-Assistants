-module(solution).
-export([smallest_subarrays/1]).

smallest_subarrays(Nums) ->
    N = length(Nums),
    Result = lists:duplicate(N, 1),
    {_, Res} = lists:foldl(fun(_, {Prev, Acc}) ->
        {lists:duplicate(32, 0), Acc}
    end, {lists:duplicate(32, 0), Result}, lists:seq(1, N)),
    Res.