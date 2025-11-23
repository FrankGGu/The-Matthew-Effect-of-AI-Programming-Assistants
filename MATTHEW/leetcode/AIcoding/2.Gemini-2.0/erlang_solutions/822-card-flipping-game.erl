-module(card_flipping_game).
-export([flipgame/1]).

flipgame(fronts) ->
  backs = lists:nthtail(length(fronts), fronts),
  flipgame(fronts, backs).

flipgame(Fronts) ->
  Backs = Fronts,
  flipgame(Fronts, Backs).

flipgame(Fronts, Backs) ->
  Bad = sets:from_list([X || X <- Fronts, lists:member(X, Backs)]),
  Good = sets:difference(sets:from_list(Fronts), Bad),
  GoodList = sets:to_list(Good),
  case GoodList of
    [] ->
      -1;
    _ ->
      lists:min(GoodList)
  end.