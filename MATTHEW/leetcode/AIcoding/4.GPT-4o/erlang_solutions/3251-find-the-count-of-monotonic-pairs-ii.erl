-module(solution).
-export([monotonicPairs/1]).

monotonicPairs(List) ->
    MonotonicCount = count_monotonic(List, 0, 0, 0),
    MonotonicCount.

count_monotonic([], _, Count, _) -> 
    Count;
count_monotonic([_], _, Count, _) -> 
    Count;
count_monotonic([H1, H2 | T], Prev, Count, Same) ->
    NewCount = if 
        H1 == H2 -> 
            count_monotonic([H2 | T], H2, Count + Same + 1, Same + 1);
        H1 < H2 -> 
            count_monotonic([H2 | T], H2, Count + 1, 0);
        H1 > H2 -> 
            count_monotonic([H2 | T], H2, Count + 1, 0)
    end.