-module(solution).
-export([count_good_partitions/1]).

count_good_partitions(N) when N >= 1 ->
    count_good_partitions(N, 0, 0).

count_good_partitions(0, GoodCount, _) ->
    GoodCount;
count_good_partitions(Remaining, GoodCount, Last) ->
    NewGoodCount = GoodCount + (if Last > 0 -> 1; true -> 0 end),
    count_good_partitions(Remaining - 1, NewGoodCount, Remaining).