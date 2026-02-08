-module(target_sum).
-export([find_target_sum_partitions/2]).

find_target_sum_partitions(Numbers, S) ->
    Total = lists:sum(Numbers),
    if
        (Total + S) rem 2 /= 0 -> -1;
        true ->
            Target = (Total + S) div 2,
            dp(Numbers, Target)
    end.

dp([], 0) -> 1;
dp([], _) -> 0;
dp([H | T], N) when N < 0 -> 0;
dp([H | T], N) ->
    dp(T, N - H) + dp(T, N).