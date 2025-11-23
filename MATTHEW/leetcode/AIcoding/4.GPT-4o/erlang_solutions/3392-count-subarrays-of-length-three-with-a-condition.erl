-module(solution).
-export([count_subarrays/1]).

count_subarrays(List) ->
    count_subarrays(List, 0, length(List)).

count_subarrays(_, Count, Len) when Len < 3 ->
    Count;

count_subarrays([A, B, C | Tail], Count, Len) ->
    NewCount = if (A + 1 == B) andalso (B + 1 == C) -> Count + 1; true -> Count end,
    count_subarrays([B, C | Tail], NewCount, Len - 1).