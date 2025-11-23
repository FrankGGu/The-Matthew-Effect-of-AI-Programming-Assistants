-module(solution).
-export([full_bloom_flowers/2]).

full_bloom_flowers(Flowers, People) ->
    {Starts, Ends} = lists:unzip(Flowers),
    SortedStarts = lists:sort(Starts),
    SortedEnds = lists:sort(Ends),
    lists:map(fun(P) -> count_less(SortedStarts, P + 1) - count_less(SortedEnds, P) end, People).

count_less(List, Target) ->
    count_less(List, Target, 0, length(List)).

count_less([], _, Count, _) -> Count;
count_less([H|T], Target, Count, Len) when H < Target ->
    count_less(T, Target, Count + 1, Len - 1);
count_less(_, _, Count, _) -> Count.