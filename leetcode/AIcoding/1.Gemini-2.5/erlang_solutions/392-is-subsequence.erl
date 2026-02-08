-module(solution).
-export([isSubsequence/2]).

isSubsequence(S_bin, T_bin) ->
    S_list = binary_to_list(S_bin),
    T_list = binary_to_list(T_bin),
    is_subsequence_recursive(S_list, T_list).

is_subsequence_recursive([], _T_list) ->
    true;
is_subsequence_recursive(_S_list, []) ->
    false;
is_subsequence_recursive([Sh|St], [Th|Tt]) when Sh == Th ->
    is_subsequence_recursive(St, Tt);
is_subsequence_recursive(S_list, [_Th|Tt]) ->
    is_subsequence_recursive(S_list, Tt).