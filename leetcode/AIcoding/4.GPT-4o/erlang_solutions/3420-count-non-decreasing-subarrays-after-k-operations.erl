-module(solution).
-export([count_non_decreasing_subarrays/2]).

count_non_decreasing_subarrays(A, K) ->
    N = length(A),
    Count = count_subarrays(A, K, N, 0, 0, 0),
    Count.

count_subarrays(_, 0, N, Start, Count, Result) when Start >= N ->
    Result + Count;
count_subarrays(A, K, N, Start, Count, Result) ->
    case Start < N of
        true ->
            NewCount = Count + 1,
            case (Start + Count + K) < N of
                true ->
                    case (lists:nth(Start + Count + 1, A) < lists:nth(Start + 1, A)) of
                        true -> count_subarrays(A, K - 1, N, Start + 1, 1, Result + NewCount);
                        false -> count_subarrays(A, K, N, Start + 1, NewCount, Result + NewCount)
                    end;
                false -> Result + NewCount
            end;
        false -> Result
    end.