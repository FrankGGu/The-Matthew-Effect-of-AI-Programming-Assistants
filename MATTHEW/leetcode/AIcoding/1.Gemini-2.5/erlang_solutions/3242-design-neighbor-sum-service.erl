-module(neighbor_sum_service).
-export([new/1, update/3, get_neighbor_sum/2]).

new(Nums) ->
    Arr = array:from_list(Nums),
    Size = array:size(Arr),
    {Arr, Size}.

update(Index, Val, {Arr, Size}) ->
    NewArr = array:set(Index, Val, Arr),
    {NewArr, Size}.

get_neighbor_sum(Index, {Arr, Size}) ->
    Sum1 = if
               Index - 1 >= 0 ->
                   array:get(Index - 1, Arr);
               true ->
                   0
           end,

    Sum2 = if
               Index + 1 < Size ->
                   array:get(Index + 1, Arr);
               true ->
                   0
           end,
    Sum1 + Sum2.