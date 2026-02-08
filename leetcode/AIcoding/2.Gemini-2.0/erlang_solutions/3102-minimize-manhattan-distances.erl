-module(minimize_manhattan_distances).
-export([solve/1]).

solve(Points) ->
  {Xs, Ys} = lists:foldl(
    fun({X, Y}, {AccX, AccY}) ->
      {[X | AccX], [Y | AccY]}
    end,
    {[], []},
    Points
  ),
  SortedXs = lists:sort(Xs),
  SortedYs = lists:sort(Ys),
  MedianX = lists:nth(length(SortedXs) div 2, SortedXs),
  MedianY = lists:nth(length(SortedYs) div 2, SortedYs),
  lists:foldl(
    fun({X, Y}, Acc) ->
      Acc + abs(X - MedianX) + abs(Y - MedianY)
    end,
    0,
    Points
  ).