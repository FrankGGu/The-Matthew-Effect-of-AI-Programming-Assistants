-module(solution).
-export([max_distance/1]).

max_distance(Houses) ->
    N = length(Houses),
    FirstColor = hd(Houses),
    LastColor = hd(lists:reverse(Houses)),
    MaxDistance1 = find_distance(Houses, FirstColor, N),
    MaxDistance2 = find_distance(Houses, LastColor, N),
    lists:max([MaxDistance1, MaxDistance2]).

find_distance(Houses, Color, N) ->
    case lists:prefix(Houses, [Color]) of
        true -> N - 1;
        false -> case lists:prefix(lists:reverse(Houses), [Color]) of
            true -> N - 1;
            false -> 0
        end
    end.