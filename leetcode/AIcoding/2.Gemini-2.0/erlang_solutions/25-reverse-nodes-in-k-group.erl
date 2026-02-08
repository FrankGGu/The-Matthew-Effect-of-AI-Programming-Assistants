-module(reverse_k_group).
-export([reverseKGroup/2]).

-spec reverseKGroup(list(), integer()) -> list().
reverseKGroup(List, K) ->
    reverseKGroup(List, K, []).

reverseKGroup([], _K, Acc) ->
    lists:reverse(Acc);
reverseKGroup(List, K, Acc) ->
    {Group, Rest} = lists:split(K, List),
    case length(Group) == K of
        true ->
            reverseKGroup(Rest, K, Acc ++ lists:reverse(Group));
        false ->
            Acc ++ Group
    end.