-module(maximize_palindrome_length_from_subsequences).
-export([longest_palindrome/1]).

longest_palindrome(S) ->
    N = erlang:length(S),
    DP = array:new(N, {default, 0}),
    lists:foreach(fun(I) -> array:set(I, I, 0, DP) end, lists:seq(0, N-1)),
    lists:foreach(fun(I) -> array:set(I, I+1, 1, DP) end, lists:seq(0, N-2)),
    lists:foreach(fun(J) ->
        lists:foreach(fun(I) ->
            if
                I > J -> ok;
                true ->
                    if
                        S[I] == S[J] ->
                            array:set(I, J, array:get(I+1, J-1) + 2, DP);
                        true ->
                            array:set(I, J, max(array:get(I+1, J), array:get(I, J-1)), DP)
                    end
            end
        end, lists:seq(0, J-1))
    end, lists:seq(1, N-1)),
    array:get(0, N-1).

array_get(A, I, J) when I > J -> 0;
array_get(A, I, J) -> array:get(I, J, A).

array_set(A, I, J, V) when I > J -> A;
array_set(A, I, J, V) -> array:set(I, J, V, A).