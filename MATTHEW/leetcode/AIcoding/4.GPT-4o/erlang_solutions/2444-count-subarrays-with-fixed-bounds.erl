-module(solution).
-export([countSubarrays/3]).

countSubarrays(A, minK, maxK) ->
    count_subarrays(A, minK, maxK, 0, 0, 0, 0).

count_subarrays([], _, _, Count, _, _) ->
    Count;
count_subarrays([H | T], minK, maxK, Count, start, end) ->
    case H of
        _ when H < minK; H > maxK ->
            count_subarrays(T, minK, maxK, 0, 0, 0);
        _ when H >= minK, H =< maxK ->
            NewCount = Count + end + 1,
            case start of
                0 -> count_subarrays(T, minK, maxK, NewCount, 1, 1);
                _ -> count_subarrays(T, minK, maxK, NewCount, start + 1, end + 1)
            end
        end
    end.