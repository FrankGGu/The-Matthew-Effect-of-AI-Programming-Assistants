-module(closest_to_target).
-export([find_best_value/2]).

find_best_value(Arr, Target) ->
  lists:foldl(
    fun(X, {Best, Diff}) ->
      NewAnd = X band Best;
      NewDiff = abs(NewAnd - Target);
      if NewDiff < Diff then
        {NewAnd, NewDiff}
      else
        {Best, Diff}
      end
    end,
    {lists:last(Arr), abs(lists:last(Arr) - Target)},
    Arr
  ).