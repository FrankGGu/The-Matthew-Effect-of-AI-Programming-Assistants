-module(solution).
-export([find_nearest_point/3]).

find_nearest_point(X, Y, Points) ->
    find_nearest_point_helper(X, Y, Points, 0, -1, -1).

find_nearest_point_helper(_TargetX, _TargetY, [], _CurrentIdx, _MinDist, BestIdx) ->
    BestIdx;
find_nearest_point_helper(TargetX, TargetY, [[Px, Py] | RestPoints], CurrentIdx, MinDist, BestIdx) ->
    if
        Px == TargetX; Py == TargetY ->
            Dist = math:abs(Px - TargetX) + math:abs(Py - TargetY),
            if
                MinDist == -1; Dist < MinDist ->
                    find_nearest_point_helper(TargetX, TargetY, RestPoints, CurrentIdx + 1, Dist, CurrentIdx);
                true ->
                    find_nearest_point_helper(TargetX, TargetY, RestPoints, CurrentIdx + 1, MinDist, BestIdx)
            end;
        true ->
            find_nearest_point_helper(TargetX, TargetY, RestPoints, CurrentIdx + 1, MinDist, BestIdx)
    end.