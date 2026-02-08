-module(maximum_number_achievable_transfer_requests).
-export([maximum_requests/2]).

maximum_requests(N, Requests) ->
    len = length(Requests),
    max_achievable(N, Requests, 0, 0, len).

max_achievable(N, Requests, Mask, Count, Len) ->
    if Mask =:= 1 bsl Len,
        true ->
            Count;
        true ->
            New_count =
                case is_achievable(N, Requests, Mask) of
                    true ->
                        Count + count_bits(Mask);
                    false ->
                        Count
                end,
            max(max_achievable(N, Requests, Mask + 1, Count, Len),
                max_achievable(N, Requests, Mask + 1, New_count, Len))
    end.

is_achievable(N, Requests, Mask) ->
    Counts = lists:duplicate(N, 0),
    is_achievable_helper(Requests, Mask, Counts, 0).

is_achievable_helper([], _, Counts, _) ->
    lists:all(fun(C) -> C =:= 0 end, Counts);
is_achievable_helper([Request | Rest], Mask, Counts, Index) ->
    if (Mask band (1 bsl Index)) =:= 0,
        true ->
            is_achievable_helper(Rest, Mask, Counts, Index + 1);
        true ->
            [From, To] = Request,
            New_counts = lists:replace(From, element(From+1, Counts) - 1, Counts),
            New_counts2 = lists:replace(To, element(To+1, New_counts) + 1, New_counts),
            is_achievable_helper(Rest, Mask, New_counts2, Index + 1)
    end.

count_bits(0) -> 0;
count_bits(N) -> (N band 1) + count_bits(N bsr 1).