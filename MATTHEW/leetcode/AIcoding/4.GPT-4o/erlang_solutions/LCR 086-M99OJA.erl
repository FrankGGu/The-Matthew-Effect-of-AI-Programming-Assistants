-module(solution).
-export([partition/1]).

partition(S) ->
    Lists = lists:map(fun(X) -> string:to_list(X) end, string:tokens(S, "")),
    partition_helper(Lists, [], []).

partition_helper([], Current, Acc) ->
    [lists:reverse(Current) | Acc];
partition_helper([H | T], Current, Acc) ->
    case is_palindrome(H) of
        true -> partition_helper(T, [H | Current], Acc);
        false -> partition_helper(T, Current, [lists:reverse(Current) | Acc])
    end.

is_palindrome(List) ->
    List == lists:reverse(List).