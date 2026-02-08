-module(solution).
-export([count_segments/1]).

count_segments(S) ->
    count_segments(S, 0, false).

count_segments([], Count, _) ->
    Count;
count_segments([H | T], Count, InSegment) ->
    case H of
        $  ->
            if
                InSegment ->
                    count_segments(T, Count, false);
                true ->
                    count_segments(T, Count, false)
            end;
        _ ->
            count_segments(T, Count + 1, true)
    end.