-module(shortest_subarray_or_at_least_k).
-export([shortest_subarray/2]).

shortest_subarray(A, K) ->
    shortest_subarray(A, K, 0, length(A), 1 bsl 31, 0).

shortest_subarray(A, K, Start, End, MinLen, CurrentOr) ->
    case Start >= End of
        true ->
            case MinLen == 1 bsl 31 of
                true -> -1;
                false -> MinLen
            end;
        false ->
            NewOr = CurrentOr bor lists:nth(Start + 1, A),
            case NewOr >= K of
                true ->
                    shortest_subarray(A, K, Start + 1, End, min(MinLen, Start + 1), 0);
                false ->
                    shortest_subarray(A, K, Start + 1, End, MinLen, NewOr)
            end
    end.