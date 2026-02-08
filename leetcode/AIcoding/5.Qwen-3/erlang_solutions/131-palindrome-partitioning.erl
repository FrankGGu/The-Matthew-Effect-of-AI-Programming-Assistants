-module(palindrome_partitioning).
-export([partition/1]).

partition(S) ->
    partition(S, []).

partition([], Acc) ->
    lists:reverse(Acc);
partition(S, Acc) ->
    lists:foldl(fun(I, Acc2) ->
                        Sub = lists:sublist(S, I),
                        case is_palindrome(Sub) of
                            true ->
                                partition(lists:nthtail(I, S), [Sub | Acc2]);
                            false ->
                                Acc2
                        end
                end, [], lists:seq(1, length(S))).

is_palindrome(L) ->
    L == lists:reverse(L).