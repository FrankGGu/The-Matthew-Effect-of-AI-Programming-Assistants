-module(longest_palindromic_subsequence).
-export([longest_palindromic_subsequence/1]).

longest_palindromic_subsequence(S) ->
    N = erlang:length(S),
    DP = array:new(N, {default, 0}),
    lists:foreach(fun(I) -> array:set(I, I, 1, DP) end, lists:seq(0, N-1)),
    lists:foreach(fun(Len) ->
        lists:foreach(fun(I) ->
            J = I + Len,
            if
                J >= N -> ok;
                true ->
                    if
                        erlang:element(I+1, S) == erlang:element(J+1, S) ->
                            if
                                Len == 1 -> array:set(I, J, 2, DP);
                                true -> array:set(I, J, array:get(I+1, J-1) + 2, DP)
                            end;
                        true -> array:set(I, J, array:get(I+1, J) rem 1000000007, DP)
                    end
            end
        end, lists:seq(0, N - Len - 1))
    end, lists:seq(1, N-1)),
    array:get(0, N-1).

array:get(I, J) -> array:get({I, J}).

array:set(I, J, V, A) -> array:set({I, J}, V, A).