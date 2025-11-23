-module(solution).
-export([distribute_cookies/2]).

distribute_cookies(Cookies, K) ->
    Min = lists:min(Cookies),
    Max = lists:max(Cookies),
    distribute(Cookies, K, Min, Max).

distribute(Cookies, K, Min, Max) when Min < Max ->
    Mid = (Min + Max) div 2,
    case count_cookies(Cookies, Mid, K) of
        true -> distribute(Cookies, K, Min, Mid);
        false -> distribute(Cookies, K, Mid + 1, Max)
    end;
distribute(_, _, Min, Min) -> Min.

count_cookies(Cookies, Target, K) ->
    distribute_helper(Cookies, 0, K, 0, Target).

distribute_helper([], _, K, Count, Target) -> Count =< Target;
distribute_helper([H | T], Used, K, Count, Target) ->
    if
        Used < K ->
            distribute_helper(T, Used + 1, K, Count + H, Target);
        true ->
            distribute_helper(T, Used, K, Count, Target)
    end.