-module(beautiful_arrangement).
-export([count_arrangement/1]).

count_arrangement(N) ->
    count_arrangements(lists:seq(1, N), 1).

count_arrangements([], _) ->
    1;
count_arrangements(Nums, Pos) ->
    lists:sum([
        count_arrangements(lists:delete(Num, Nums), Pos + 1)
        || Num <- Nums,
           (Num rem Pos == 0) orelse (Pos rem Num == 0)
    ]).