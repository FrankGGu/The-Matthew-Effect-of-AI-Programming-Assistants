-module(neighbor_sum).
-export([init/1, update/3, sum/2]).

init(Nums) ->
    {array:from_list(Nums), length(Nums)}.

update({Array, Size}, Index, Val) ->
    NewArray = array:set(Index, Val, Array),
    {NewArray, Size}.

sum({Array, Size}, Index) ->
    Left = if Index > 0 -> array:get(Index - 1, Array); true -> 0 end,
    Right = if Index < Size - 1 -> array:get(Index + 1, Array); true -> 0 end,
    Left + Right.