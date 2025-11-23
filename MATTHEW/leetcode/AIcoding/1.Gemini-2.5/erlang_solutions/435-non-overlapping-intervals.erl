-module(solution).
-export([eraseOverlapIntervals/1]).

eraseOverlapIntervals(Intervals) ->
    N = length(Intervals),
    case N of
        0 -> 0;
        _ ->
            SortedIntervals = lists:sort(fun([_S1, E1], [_S2, E2]) -> E1 < E2 end, Intervals),

            [FirstStart, FirstEnd] = hd(SortedIntervals),

            {MaxNonOverlapping, _} = lists:foldl(
                fun([CurrentStart, CurrentEnd], {AccCount, LastEndTime}) ->
                    if
                        CurrentStart >= LastEndTime ->
                            {AccCount + 1, CurrentEnd};
                        true ->
                            {AccCount, LastEndTime}
                    end
                end,
                {1, FirstEnd},
                tl(SortedIntervals)
            ),

            N - MaxNonOverlapping
    end.