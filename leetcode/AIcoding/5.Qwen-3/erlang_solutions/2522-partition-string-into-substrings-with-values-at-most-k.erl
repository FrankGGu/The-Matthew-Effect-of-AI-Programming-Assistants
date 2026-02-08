-module(partition_string_into_substrings_with_values_at_most_k).
-export([partitionString/2]).

partitionString(S, K) ->
    partitionString(S, K, 0, 0, 0).

partitionString([], _, _, _, Count) ->
    Count;
partitionString([C | T], K, CurrentVal, Length, Count) ->
    Digit = C - $0,
    NewVal = CurrentVal * 10 + Digit,
    if
        NewVal > K ->
            partitionString(T, K, Digit, 1, Count + 1);
        true ->
            partitionString(T, K, NewVal, Length + 1, Count)
    end.