-module(two_furthest_houses).
-export([max_distance/1]).

max_distance(Colors) ->
    max_distance_helper(Colors, 0, 0, 0).

max_distance_helper([], MaxDist, _, _) ->
    MaxDist;
max_distance_helper(Colors, MaxDist, L, R) ->
    Len = length(Colors),
    First = lists:nth(1, Colors),
    Last = lists:nth(Len, Colors),

    case First /= Last of
        true ->
            max_distance_helper([], max(MaxDist, Len - 1), L, R);
        false ->
            FirstDiffIndex = find_first_diff(Colors, First, 1, Len);
            LastDiffIndex = find_last_diff(Colors, Last, 1, Len);
            max_distance_helper([], max(MaxDist, max(Len - FirstDiffIndex, LastDiffIndex - 1)), L, R)
    end.

find_first_diff(Colors, Color, Index, Len) ->
    case lists:nth(Index, Colors) /= Color of
        true ->
            Index;
        false ->
            case Index < Len of
                true ->
                    find_first_diff(Colors, Color, Index + 1, Len);
                false ->
                    Len + 1
            end
    end.

find_last_diff(Colors, Color, Index, Len) ->
    case lists:nth(Len - Index + 1, Colors) /= Color of
        true ->
            Len - Index + 1;
        false ->
            case Index < Len of
                true ->
                    find_last_diff(Colors, Color, Index + 1, Len);
                false ->
                    0
            end
    end.