-module(solution).
-export([swap_nodes/2]).

-spec swap_nodes(List :: list(), K :: integer()) -> list().
swap_nodes(List, K) ->
    swap_nodes_helper(List, K, 1, [], List).

swap_nodes_helper([], _, _, Acc, _OriginalList) ->
    lists:reverse(Acc);
swap_nodes_helper(List, K, K, Acc, OriginalList) ->
    {Element, Rest} = lists:split(1, List),
    Length = length(OriginalList),
    K2 = Length - K + 1,
    {Element2, _} = lists:split(K2, OriginalList),
    swap_nodes_helper(Rest, K, K + 1, Acc ++ Element2, OriginalList);
swap_nodes_helper(List, K, Current, Acc, OriginalList) ->
    Length = length(OriginalList),
    K2 = Length - K + 1,
    if Current == K2 ->
        {Element, Rest} = lists:split(1, List),
        {Element2, _} = lists:split(K, OriginalList),
        swap_nodes_helper(Rest, K, Current + 1, Acc ++ Element2, OriginalList);
    true ->
        {Element, Rest} = lists:split(1, List),
        swap_nodes_helper(Rest, K, Current + 1, Acc ++ Element, OriginalList)
    end.