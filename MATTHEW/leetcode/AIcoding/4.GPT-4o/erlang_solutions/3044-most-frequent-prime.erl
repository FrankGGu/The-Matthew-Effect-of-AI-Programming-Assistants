-module(solution).
-export([most_frequent_prime/1]).

most_frequent_prime(List) ->
    PrimeCounts = lists:foldl(fun(X, Acc) -> 
        case is_prime(X) of
            true -> 
                maps:update_with(X, fun(Count) -> Count + 1 end, 1, Acc);
            false -> 
                Acc
        end
    end, maps:new(), List),
    case maps:to_list(PrimeCounts) of
        [] -> -1;
        Counts -> 
            lists:max(fun({_, Count1}, {_, Count2}) -> Count1 > Count2 end, Counts)
    end.

is_prime(N) when N < 2 -> false;
is_prime(2) -> true;
is_prime(N) when N rem 2 == 0 -> false;
is_prime(N) -> 
    lists:all(fun(I) -> N rem I /= 0 end, lists:seq(3, math:floor(math:sqrt(N)), 2)).