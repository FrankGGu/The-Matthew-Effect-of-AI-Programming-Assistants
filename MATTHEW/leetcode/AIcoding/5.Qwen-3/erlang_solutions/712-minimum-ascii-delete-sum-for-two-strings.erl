-module(minimum_ascii_delete_sum_for_two_strings).
-export([minimumDeleteSum/3]).

minimumDeleteSum(S1, S2, _)->

    N = length(S1),
    M = length(S2),

    DP = array:new([{size, N+1}, {default, 0}]),
    DP1 = array:new([{size, M+1}, {default, 0}]),

    lists:foreach(fun(I) -> 
        array:set(I, array:get(I, DP1), DP)
    end, lists:seq(1, N)),

    lists:foreach(fun(I) ->
        lists:foreach(fun(J) ->
            if
                I == 0 -> array:set({I,J}, array:get({I,J-1}, DP1) + erlang:element(J, S2), DP1);
                J == 0 -> array:set({I,J}, array:get({I-1,J}, DP1) + erlang:element(I, S1), DP1);
                true ->
                    if
                        erlang:element(I, S1) == erlang:element(J, S2) ->
                            array:set({I,J}, array:get({I-1,J-1}, DP1), DP1);
                        true ->
                            array:set({I,J}, min(array:get({I-1,J}, DP1) + erlang:element(I, S1), array:get({I,J-1}, DP1) + erlang:element(J, S2)), DP1)
                    end
            end
        end, lists:seq(1, M))
    end, lists:seq(1, N)),

    array:get({N,M}, DP1).