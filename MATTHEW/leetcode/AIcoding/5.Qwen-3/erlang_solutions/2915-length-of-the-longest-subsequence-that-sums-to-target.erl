-module(solution).
-export([length_of_longest_subsequence/2]).

length_of_longest_subsequence(Nums, Target) ->
    Max = length(Nums),
    DP = array:new(Max + 1, {default, -1}),
    array:set(0, 0, DP),
    lists:foreach(fun(N) -> update_dp(DP, N, Target) end, Nums),
    array:get(Target, DP).

update_dp(DP, Num, Target) ->
    lists:foreach(fun(I) ->
        if
            I - Num >= 0,
            array:get(I - Num, DP) /= -1 ->
                Prev = array:get(I - Num, DP),
                Current = array:get(I, DP),
                if
                    Current < Prev + 1 ->
                        array:set(I, Prev + 1, DP);
                    true ->
                        ok
                end;
            true ->
                ok
        end
    end, lists:seq(Target, 0, -1)).