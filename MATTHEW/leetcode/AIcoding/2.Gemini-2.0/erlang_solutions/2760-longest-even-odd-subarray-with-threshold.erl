-module(longest_even_odd_subarray).
-export([find_longest_subarray/2]).

find_longest_subarray(Nums, Threshold) ->
    find_longest_subarray(Nums, Threshold, 0, 0, 0).

find_longest_subarray([], _, MaxLength, _, _) ->
    MaxLength;
find_longest_subarray([H|T], Threshold, MaxLength, CurrentLength, Prev) ->
    case check_condition(H, Threshold, Prev) of
        true ->
            find_longest_subarray(T, Threshold, max(MaxLength, CurrentLength + 1), CurrentLength + 1, H rem 2);
        false ->
            find_longest_subarray(T, Threshold, MaxLength, 0, -1)
    end.

check_condition(H, Threshold, Prev) ->
    H rem 2 == 0 andalso H =< Threshold orelse
    Prev == 0 andalso H rem 2 == 1 andalso H =< Threshold orelse
    Prev == 1 andalso H rem 2 == 0 andalso H =< Threshold.