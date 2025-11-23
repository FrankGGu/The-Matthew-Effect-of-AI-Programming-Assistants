-module(solution).
-export([rearrangeSticks/2]).

rearrangeSticks(N, K) ->
    Mod = 1000000007,
    DP = array:new(N+1, {default, 0}),
    DP1 = array:set(0, 1, DP),
    lists:foreach(fun(I) -> 
        DP2 = array:new(I+1, {default, 0}),
        DP2 = array:set(I, 1, DP2),
        lists:foreach(fun(J) ->
            if J == I -> ok;
               true ->
                    Val = (array:get(J, DP1) * (I - J)) rem Mod,
                    DP2 = array:set(J, (array:get(J, DP2) + Val) rem Mod, DP2)
            end
        end, lists:seq(0, I-1)),
        DP1 = DP2
    end, lists:seq(1, N)),
    array:get(K, DP1).