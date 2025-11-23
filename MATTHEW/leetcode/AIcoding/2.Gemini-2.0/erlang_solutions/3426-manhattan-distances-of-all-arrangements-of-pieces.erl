-module(manhattan_distances).
-export([solve/1]).

solve(positions) ->
  N = length(positions),
  {Xs, Ys} = lists:foldl(
    fun({X, Y}, {AccXs, AccYs}) ->
      {AccXs ++ [X], AccYs ++ [Y]}
    end, {[], []}, positions
  ),
  SortedXs = lists:sort(Xs),
  SortedYs = lists:sort(Ys),

  PrefixSumXs = prefix_sum(SortedXs),
  PrefixSumYs = prefix_sum(SortedYs),

  sum([
    sum([
      manhattan_distance(
        {lists:nth(I, Xs), lists:nth(J, Ys)},
        {lists:nth(K, Xs), lists:nth(L, Ys)},
        SortedXs, SortedYs, PrefixSumXs, PrefixSumYs
      )
      || K <- lists:seq(1, N), L <- lists:seq(1, N)
    ])
    || I <- lists:seq(1, N), J <- lists:seq(1, N)
  ]).

prefix_sum(L) ->
  lists:foldl(
    fun(X, {AccSum, Acc}) ->
      NewSum = AccSum + X,
      {NewSum, Acc ++ [NewSum]}
    end, {0, [0]}, L
  ).

manhattan_distance(
  {X1, Y1}, {X2, Y2}, SortedXs, SortedYs, PrefixSumXs, PrefixSumYs
) ->
  calculate_x_distance(X1, SortedXs, PrefixSumXs) +
  calculate_y_distance(Y1, SortedYs, PrefixSumYs).

calculate_x_distance(X, SortedXs, PrefixSumXs) ->
  Index = lists:keyfind(X, 1, lists:zip(SortedXs, lists:seq(1, length(SortedXs)))),
  case Index of
    false -> 0;
    {_, I} ->
      (I - 1) * X - lists:nth(I - 1, PrefixSumXs) +
      (lists:last(PrefixSumXs) - lists:nth(I - 1, PrefixSumXs)) - (length(SortedXs) - I + 1) * X
  end.

calculate_y_distance(Y, SortedYs, PrefixSumYs) ->
  Index = lists:keyfind(Y, 1, lists:zip(SortedYs, lists:seq(1, length(SortedYs)))),
  case Index of
    false -> 0;
    {_, I} ->
      (I - 1) * Y - lists:nth(I - 1, PrefixSumYs) +
      (lists:last(PrefixSumYs) - lists:nth(I - 1, PrefixSumYs)) - (length(SortedYs) - I + 1) * Y
  end.