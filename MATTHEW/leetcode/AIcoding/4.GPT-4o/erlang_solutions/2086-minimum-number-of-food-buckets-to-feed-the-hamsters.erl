-module(solution).
-export([min_food_buckets/1]).

min_food_buckets(Food) ->
    N = length(Food),
    SortedFood = lists:sort(Food),
    min_buckets(SortedFood, N, 0).

min_buckets([], _, Buckets) -> Buckets;
min_buckets([H | T], N, Buckets) ->
    NewBuckets = Buckets + 1,
    Remaining = N - 1,
    min_buckets(T, Remaining, NewBuckets).