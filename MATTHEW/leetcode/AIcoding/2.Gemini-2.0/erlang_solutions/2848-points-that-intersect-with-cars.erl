-module(points_intersect_cars).
-export([number_of_points/1]).

number_of_points(Nums) ->
  Ranges = to_ranges(Nums),
  Points = lists:foldl(
    fun(Range, Acc) ->
      lists:seq(element(1, Range), element(2, Range)) ++ Acc
    end,
    [],
    Ranges
  ),
  length(lists:usort(Points)).

to_ranges([]) ->
  [].
to_ranges(Nums) ->
  lists:foldl(
    fun(Pair, Acc) ->
      {A, B} = Pair,
      Acc ++ [{min(A, B), max(A, B)}]
    end,
    [],
    lists:chunk(2, Nums)
  ).