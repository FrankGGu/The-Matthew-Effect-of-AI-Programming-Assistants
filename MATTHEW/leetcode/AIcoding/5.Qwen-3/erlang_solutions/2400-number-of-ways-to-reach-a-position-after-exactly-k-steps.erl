-module(solution).
-export([num_ways/3]).

num_ways(Pos, StartPos, K) ->
    Max = 1000000007,
    DP = array:new(K+1, fun(_) -> array:new(2*Pos+1, fun(_) -> 0 end) end),
    array:set({0, StartPos}, 1, DP),
    lists:foreach(fun(I) -> update(DP, I, Pos, Max) end, lists:seq(1, K)),
    array:get({K, Pos}, DP).

update(DP, I, Pos, Max) ->
    lists:foreach(fun(S) -> 
        Val = array:get({I-1, S}, DP),
        if Val > 0 ->
            NewVal = (array:get({I, S+1}, DP) + Val) rem Max,
            array:set({I, S+1}, NewVal, DP);
        true -> ok
        end,
        if Val > 0 ->
            NewVal2 = (array:get({I, S-1}, DP) + Val) rem Max,
            array:set({I, S-1}, NewVal2, DP);
        true -> ok
        end
    end, lists:seq(0, 2*Pos)).