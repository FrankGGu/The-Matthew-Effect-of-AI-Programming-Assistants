-module(maximum_eaten_apples).
-export([max_eaten_apples/2]).

max_eaten_apples(Apples, Days) ->
  max_eaten_apples(Apples, Days, 0, gb_trees:empty()).

max_eaten_apples([], [], Day, Tree) ->
  max_eaten_apples_helper(Day, Tree, 0);
max_eaten_apples([Apple | RestApples], [Day | RestDays], CurrentDay, Tree) ->
  NewTree = gb_trees:insert(CurrentDay + Day - 1, Apple, Tree),
  max_eaten_apples(RestApples, RestDays, CurrentDay + 1, NewTree).

max_eaten_apples_helper(Day, Tree, Acc) ->
  case gb_trees:smallest(Tree) of
    none ->
      Acc;
    {ExpDay, Apples} ->
      case ExpDay < Day of
        true ->
          NewTree = gb_trees:delete(ExpDay, Tree),
          max_eaten_apples_helper(Day, NewTree, Acc);
        false ->
          case Apples > 1 of
            true ->
              NewTree = gb_trees:update(ExpDay, Apples - 1, Tree),
              max_eaten_apples_helper(Day + 1, NewTree, Acc + 1);
            false ->
              NewTree = gb_trees:delete(ExpDay, Tree),
              max_eaten_apples_helper(Day + 1, NewTree, Acc + 1)
          end
      end
  end.