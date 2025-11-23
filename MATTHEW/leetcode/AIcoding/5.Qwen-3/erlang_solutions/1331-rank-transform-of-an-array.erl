-module(rank_transform_of_an_array).
-export([array_rank_transform/1]).

array_rank_transform(Nums) ->
    Sorted = lists:usort(Nums),
    Map = maps:from_list([{Val, I+1} || {I, Val} <- lists:enumerate(Sorted)]),
    [maps:get(N, Map) || N <- Nums].