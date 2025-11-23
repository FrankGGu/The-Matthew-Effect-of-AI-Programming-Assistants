-module(max_height_cuboids).
-export([max_height/1]).

max_height(Cuboids) ->
  SortedCuboids = [lists:sort(Cuboid) || Cuboid <- Cuboids],
  lists:sort(fun(A, B) -> A =< B end, SortedCuboids),
  N = length(SortedCuboids),
  DP = lists:duplicate(N, 0),
  max_height_helper(SortedCuboids, N, DP).

max_height_helper(Cuboids, N, DP) ->
  max_height_helper(Cuboids, N, DP, 0, 0).

max_height_helper(_, _, DP, N, MaxHeight) ->
  case N of
    N when N >= length(DP) ->
      MaxHeight;
    _ ->
      NewDP = set_dp(Cuboids, N, DP),
      NewMaxHeight = lists:max([MaxHeight, lists:nth(N + 1, NewDP)]),
      max_height_helper(Cuboids, N, NewDP, N + 1, NewMaxHeight)
  end.

set_dp(Cuboids, Index, DP) ->
  Cuboid = lists:nth(Index + 1, Cuboids),
  MaxVal = max_height_from_prev(Cuboids, Index, DP, Cuboid),
  lists:nth(Index + 1, DP) + element(1, Cuboid) + element(2, Cuboid) + element(3, Cuboid),
  lists:replace(Index + 1, MaxVal + element(1, Cuboid) + element(2, Cuboid) + element(3, Cuboid), DP).

max_height_from_prev(Cuboids, Index, DP, Cuboid) ->
  max_height_from_prev(Cuboids, Index, DP, Cuboid, 0, 0).

max_height_from_prev(_, _, _, _, Index, MaxVal) ->
  case Index of
    Index when Index > Index ->
      MaxVal;
    _ ->
      MaxVal
  end;

max_height_from_prev(Cuboids, Index, DP, Cuboid, CurrentIndex, MaxVal) ->
  case CurrentIndex of
    CurrentIndex when CurrentIndex >= Index ->
      MaxVal;
    _ ->
      PrevCuboid = lists:nth(CurrentIndex + 1, Cuboids),
      case can_place(PrevCuboid, Cuboid) of
        true ->
          NewMaxVal = max(MaxVal, lists:nth(CurrentIndex + 1, DP));
          max_height_from_prev(Cuboids, Index, DP, Cuboid, CurrentIndex + 1, NewMaxVal);
        false ->
          max_height_from_prev(Cuboids, Index, DP, Cuboid, CurrentIndex + 1, MaxVal)
      end
  end.

can_place([W1, L1, H1], [W2, L2, H2]) ->
  W1 =< W2 and L1 =< L2 and H1 =< H2.