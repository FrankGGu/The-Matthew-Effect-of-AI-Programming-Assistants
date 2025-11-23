-module(solution).
-export([max_building/2]).

max_building(N, heights) ->
    heights1 = [{0, 0} | heights],
    heights2 = [{N, N} | heights1],
    heights3 = lists:sort(heights2),
    max_height(heights3, N).

max_height(Heights, N) ->
    Max = lists:foldl(fun({x1, h1}, {x2, h2}) ->
        D = x2 - x1,
        H = min(h1 + D, h2 + D) - (h2 - h1) div 2,
        max(H, h1)
    end, 0, zip(Heights)),
    Max.

zip([]) -> [];
zip([{X1, H1}, {X2, H2} | Rest]) -> [{X1, H1, X2, H2} | zip([{X2, H2} | Rest])].