-module(find_right_interval).
-export([find_right_interval/1]).

find_right_interval(Intervals) ->
  N = length(Intervals),
  Sorted = lists:keysort(1, lists:zip(lists:seq(0, N - 1), Intervals)),
  Starts = [element(2, element(2, I)) || I <- Sorted],
  Indices = [element(1, I) || I <- Sorted],
  [find_right(element(2, Interval), Starts, Indices) || Interval <- Intervals].

find_right({_, End}, Starts, Indices) ->
  case find_right_helper(End, Starts, Indices, 1, length(Starts)) of
    -1 -> -1;
    Index -> Index
  end.

find_right_helper(_End, _Starts, _Indices, L, R) when L > R -> -1;
find_right_helper(End, Starts, Indices, L, R) ->
  Mid = (L + R) div 2,
  case lists:nth(Mid, Starts) of
    Start when Start >= End ->
      case find_right_helper(End, Starts, Indices, L, Mid - 1) of
        -1 -> lists:nth(Mid, Indices);
        Index -> Index
      end;
    _ ->
      find_right_helper(End, Starts, Indices, Mid + 1, R)
  end.