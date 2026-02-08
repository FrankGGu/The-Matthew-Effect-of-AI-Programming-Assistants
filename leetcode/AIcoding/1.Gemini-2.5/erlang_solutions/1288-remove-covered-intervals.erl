-module(solution).
-export([remove_covered_intervals/1]).

remove_covered_intervals(Intervals) ->
    SortedIntervals = lists:sort(fun([L1, R1], [L2, R2]) ->
                                     if L1 < L2 -> true;
                                        L1 == L2 -> R1 >= R2;
                                        true -> false
                                     end
                                 end, Intervals),

    remove_covered_intervals_helper(SortedIntervals, 0, -1).

remove_covered_intervals_helper([], Count, _MaxEnd) ->
    Count;
remove_covered_intervals_helper([[_L, R]|T], Count, MaxEnd) ->
    if R > MaxEnd ->
        remove_covered_intervals_helper(T, Count + 1, R);
    true ->
        remove_covered_intervals_helper(T, Count, MaxEnd)
    end.