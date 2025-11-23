-module(letter_tile_possibilities).
-export([num_tile_possibilities/1]).

num_tile_possibilities(Tiles) ->
  List = string:to_list(Tiles),
  UniqueList = lists:usort(List),
  length(permute(UniqueList, [])).

permute([], Acc) ->
  sets:from_list(Acc);
permute(UniqueList, Acc) ->
  lists:foldl(
    fun(Char, SetAcc) ->
      RemainingList = lists:delete(Char, UniqueList, 1),
      NewAcc = Acc ++ [lists:sort(Acc ++ [Char])],
      sets:union(SetAcc, permute(RemainingList, NewAcc))
    end,
    sets:new(),
    UniqueList
  ).