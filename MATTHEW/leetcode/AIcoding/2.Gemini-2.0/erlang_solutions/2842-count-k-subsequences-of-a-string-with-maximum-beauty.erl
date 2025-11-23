-module(solution).
-export([count_k_subsequences/2]).

count_k_subsequences(S, K) ->
    Len = length(S),
    Counts = lists:foldl(fun(C, Acc) ->
        case maps:is_key(C, Acc) of
            true -> maps:update(C, maps:get(C, Acc) + 1, Acc);
            false -> maps:put(C, 1, Acc)
        end
    end, #{}, string:to_list(S)),
    SortedCounts = lists:reverse(lists:sort(maps:values(Counts))),
    case length(SortedCounts) < K of
        true -> 0;
        false ->
            MinCount = lists:nth(K, SortedCounts),
            NumWithMin = lists:foldl(fun(Count, Acc) ->
                case Count == MinCount of
                    true -> Acc + 1;
                    false -> Acc
                end
            end, 0, SortedCounts),
            GreaterThanMinSum = lists:foldl(fun(Count, Acc) ->
                case Count > MinCount of
                    true -> Acc + Count;
                    false -> Acc
                end
            end, 0, SortedCounts),
            GreaterThanMinCount = length(lists:filter(fun(Count) -> Count > MinCount end, SortedCounts)),
            MinCountSum = (K - GreaterThanMinCount) * MinCount,
            Remaining = K - GreaterThanMinCount,
            (factorial(NumWithMin) div (factorial(Remaining) * factorial(NumWithMin - Remaining))) rem 1000000007
    end.

factorial(0) -> 1;
factorial(N) -> factorial_helper(N, 1).

factorial_helper(0, Acc) -> Acc;
factorial_helper(N, Acc) -> factorial_helper(N - 1, (Acc * N) rem 1000000007).