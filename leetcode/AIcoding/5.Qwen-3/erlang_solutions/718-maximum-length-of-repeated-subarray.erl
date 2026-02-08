-module(solution).
-export([length_of_longest_common_subarray/2]).

length_of_longest_common_subarray(A, B) ->
    N = length(A),
    M = length(B),
    DP = array:new([{size, N+1}, {default, 0}]),
    Max = 0,
    lists:foreach(fun(I) ->
        lists:foreach(fun(J) ->
            if
                I > 0, J > 0, A--I == B--J ->
                    NewVal = array:get(I-1, array:get(J-1, DP)) + 1,
                    DP1 = array:set(I, array:set(J, NewVal, array:get(I, DP)), DP),
                    Max1 = max(Max, NewVal),
                    DP = DP1,
                    Max = Max1;
                true ->
                    ok
            end
        end, lists:seq(1, M))
    end, lists:seq(1, N)),
    Max.