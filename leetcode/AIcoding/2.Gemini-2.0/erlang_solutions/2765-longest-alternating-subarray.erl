-module(longest_alternating_subarray).
-export([longest_alternating_subarray/1]).

longest_alternating_subarray(Nums) ->
    longest_alternating_subarray(Nums, 0, 1, 0).

longest_alternating_subarray([], Len, CurrLen, _) ->
    max(Len, CurrLen);
longest_alternating_subarray([_], Len, CurrLen, _) ->
    max(Len, CurrLen);
longest_alternating_subarray([A, B | Rest], Len, CurrLen, PrevDiffSign) ->
    Diff = B - A,
    case Diff of
        0 ->
            longest_alternating_subarray([B | Rest], max(Len, CurrLen), 1, 0);
        _ ->
            DiffSign = signum(Diff),
            case DiffSign of
                PrevDiffSign ->
                    longest_alternating_subarray([B | Rest], max(Len, CurrLen), 2, DiffSign);
                _ ->
                    longest_alternating_subarray([B | Rest], Len, CurrLen + 1, DiffSign)
            end
    end.

signum(X) when X > 0 -> 1;
signum(X) when X < 0 -> -1;
signum(0) -> 0.

max(A, B) ->
    if A > B -> A;
    true -> B
    end.