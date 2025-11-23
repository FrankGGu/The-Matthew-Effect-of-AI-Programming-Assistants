-module(longest_square_streak).
-export([longest_square_streak/1]).

longest_square_streak(Arr) ->
  Set = sets:from_list(Arr),
  longest_streak(Set, 0, 0).

longest_streak(Set, Start, Count) ->
  case sets:is_element(Start, Set) of
    true ->
      Next = Start * Start,
      longest_streak(Set, Next, Count + 1);
    false ->
      Count
  end.

longest_square_streak(Arr) ->
  Set = sets:from_list(Arr),
  lists:foldl(
    fun(X, Max) ->
      Streak = longest_streak(Set, X, 0),
      max(Max, Streak)
    end,
    0,
    sets:to_list(Set)
  ) - 1.