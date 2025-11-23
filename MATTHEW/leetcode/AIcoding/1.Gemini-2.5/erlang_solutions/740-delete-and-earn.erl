-module(solution).
-export([deleteAndEarn/1]).

deleteAndEarn(Nums) ->
    case Nums of
        [] -> 0;
        _ ->
            MaxVal = lists:max(Nums),
            PointsArray = build_points_array(Nums, MaxVal),
            solve_dp(MaxVal, PointsArray)
    end.

build_points_array(Nums, MaxVal) ->
    InitialArray = array:new(MaxVal + 1, {default, 0}),
    lists:foldl(
      fun(Num, AccArray) ->
              CurrentPoints = array:get(Num, AccArray),
              array:set(Num, CurrentPoints + Num, AccArray)
      end,
      InitialArray,
      Nums
    ).

solve_dp(MaxVal, PointsArray) ->
    solve_dp_loop(0, MaxVal, PointsArray, 0, 0).

solve_dp_loop(I, MaxVal, PointsArray, Prev2, Prev1) when I =< MaxVal ->
    CurrentPoints = array:get(I, PointsArray),
    CurrentMax = max(Prev1, Prev2 + CurrentPoints),
    solve_dp_loop(I + 1, MaxVal, PointsArray, Prev1, CurrentMax);
solve_dp_loop(_I, _MaxVal, _PointsArray, _Prev2, Prev1) ->
    Prev1.