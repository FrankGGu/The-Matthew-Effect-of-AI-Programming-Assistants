-module(two_furthest_houses_with_different_colors).
-export([max_distance/1]).

max_distance(Houses) ->
    max_distance(Houses, 0, 0, 0).

max_distance([], _, Max, _) ->
    Max;
max_distance([H | T], Index, Max, First) ->
    case First of
        0 ->
            max_distance(T, Index + 1, Max, H);
        _ ->
            if
                H /= First ->
                    NewMax = max(Max, Index);
                    max_distance(T, Index + 1, NewMax, First);
                true ->
                    max_distance(T, Index + 1, Max, First)
            end
    end.