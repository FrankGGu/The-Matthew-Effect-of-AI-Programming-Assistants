-module(array_with_elements_not_equal_to_average_of_neighbors).
-export([rearrange/1]).

rearrange(Nums) ->
    SortedNums = lists:sort(Nums),
    rearrange_helper(SortedNums, []).

rearrange_helper([], Acc) ->
    lists:reverse(Acc);
rearrange_helper([H1, H2 | T], Acc) ->
    rearrange_helper(T, [H1, H2 | Acc]);
rearrange_helper([H], Acc) ->
    lists:reverse([H | Acc]).