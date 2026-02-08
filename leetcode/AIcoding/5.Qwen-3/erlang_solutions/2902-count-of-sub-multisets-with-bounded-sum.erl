-module(solution).
-export([num_subarrays/2]).

num_subarrays(Nums, MaxSum) ->
    len = length(Nums),
    dp = array:new(len + 1, {default, 0}),
    array:set(0, 1, dp),
    lists:foreach(fun(I) -> 
        N = array:get(I, Nums),
        arrays:for(0, MaxSum, fun(S) ->
            if S >= N ->
                array:set(S, array:get(S, dp) + array:get(S - N, dp), dp);
            true ->
                ok
            end
        end)
    end, lists:seq(0, len - 1)),
    array:get(MaxSum, dp).