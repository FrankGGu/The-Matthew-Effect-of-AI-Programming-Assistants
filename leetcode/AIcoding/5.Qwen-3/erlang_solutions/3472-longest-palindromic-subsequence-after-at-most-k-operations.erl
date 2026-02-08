-module(longest_palindromic_subsequence_after_at_most_k_operations).
-export([longestPalindromeSubseq/2]).

longestPalindromeSubseq(S, K) ->
    N = length(S),
    DP = array:new(N, {default, 0}),
    lists:foreach(fun(I) -> array:set(I, I, 1, DP) end, lists:seq(0, N-1)),
    lists:foreach(fun(Len) ->
        lists:foreach(fun(I) ->
            J = I + Len,
            if
                J >= N -> ok;
                true ->
                    if
                        S[I] == S[J] ->
                            array:set(I, J, array:get(I+1, J-1) + 2, DP);
                        true ->
                            array:set(I, J, max(array:get(I+1, J), array:get(I, J-1)), DP)
                    end
            end
        end, lists:seq(0, N - Len - 1))
    end, lists:seq(1, N-1)),

    MaxLen = array:get(0, N-1),
    MaxLen.

array:new(Size, Default) ->
    erlang:list_to_array(lists:duplicate(Size, Default)).

array:get(I, J) ->
    erlang:element(I + 1, erlang:element(J + 1, erlang:array_to_list(array:new(0, 0)))).

array:set(I, J, Val, Arr) ->
    List = erlang:array_to_list(Arr),
    NewList = lists:sublist(List, I + 1) ++ [Val] ++ lists:nthtail(I + 2, List),
    erlang:list_to_array(NewList).