-module(solution).
-export([maximum_and_sum/2]).

maximum_and_sum(Nums, K) ->
    maximum_and_sum_helper(Nums, K, 0).

maximum_and_sum_helper(_, 0, Sum) ->
    Sum;
maximum_and_sum_helper(Nums, K, Sum) ->
    {Max, NewNums} = find_max_and(Nums),
    maximum_and_sum_helper(NewNums, K - 1, Sum + Max).

find_max_and([]) ->
    {0, []};
find_max_and([H|T]) ->
    {H, [X || X <- T, (H band X) > 0]}.