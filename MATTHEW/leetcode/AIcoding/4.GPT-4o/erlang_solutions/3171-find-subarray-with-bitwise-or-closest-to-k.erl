-module(solution).
-export([closest_subarray/2]).

closest_subarray(A, K) ->
    N = length(A),
    closest_subarray(A, K, 0, 0, 0, infinity).

closest_subarray(A, K, L, R, CurrentOR, BestDiff) when R < N ->
    NewOR = bxor(CurrentOR, lists:nth(R + 1, A)),
    NewDiff = abs(NewOR - K),
    case NewDiff < BestDiff of
        true -> closest_subarray(A, K, L, R + 1, NewOR, NewDiff);
        false -> closest_subarray(A, K, L, R + 1, CurrentOR, BestDiff)
    end;
closest_subarray(A, K, L, R, CurrentOR, BestDiff) when L < N ->
    NewOR = bxor(CurrentOR, lists:nth(L + 1, A)),
    NewDiff = abs(NewOR - K),
    closest_subarray(A, K, L + 1, R, NewOR, min(NewDiff, BestDiff));
closest_subarray(_, _, _, _, _, BestDiff) ->
    BestDiff.