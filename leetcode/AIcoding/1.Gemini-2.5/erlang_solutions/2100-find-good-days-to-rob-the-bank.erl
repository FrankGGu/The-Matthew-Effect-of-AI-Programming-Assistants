-module(solution).
-export([good_days_to_rob_bank/2]).

good_days_to_rob_bank(Security, Time) ->
    N = length(Security),
    if
        N < 2 * Time + 1 -> [];
        true ->
            LeftNonIncreasing = calculate_left_non_increasing(Security),
            RightNonDecreasing = calculate_right_non_decreasing(Security),

            % Valid indices are from Time to N - Time - 1 (inclusive)
            % These correspond to 1-indexed list positions Time + 1 to N - Time
            % The length of this sublist is (N - Time) - (Time + 1) + 1 = N - 2*Time
            StartIndex = Time + 1,
            SublistLength = N - 2 * Time,

            LNI_sliced = lists:sublist(LeftNonIncreasing, StartIndex, SublistLength),
            RND_sliced = lists:sublist(RightNonDecreasing, StartIndex, SublistLength),

            find_good_days_iter_sliced(Time, Time, LNI_sliced, RND_sliced, [])
    end.

calculate_left_non_increasing(Security) ->
    case Security of
        [] -> [];
        [H|T] ->
            left_non_increasing_scan(T, H, 1, [1])
    end.

left_non_increasing_scan([], _, _, Acc) ->
    lists:reverse(Acc);
left_non_increasing_scan([H|T], Prev, PrevLen, Acc) ->
    NewLen = if H =< Prev -> PrevLen + 1; true -> 1 end,
    left_non_increasing_scan(T, H, NewLen, [NewLen|Acc]).

calculate_right_non_decreasing(Security) ->
    ReversedSec = lists:reverse(Security),
    case ReversedSec of
        [] -> [];
        [H|T] ->
            % For right_non_decreasing (security[i] <= security[i+1]),
            % when processing the reversed list (S_N-1, S_N-2, ..., S_0),
            % we compare current element H (S_k) with previous element Prev (S_k+1).
            % The condition becomes H <= Prev (S_k <= S_k+1), which is exactly
            % the condition for left_non_increasing_scan.
            ReversedRight = left_non_increasing_scan(T, H, 1, [1]),
            lists:reverse(ReversedRight)
    end.

find_good_days_iter_sliced(CurrentIndex, Time, [], [], Acc) ->
    lists:reverse(Acc);
find_good_days_iter_sliced(CurrentIndex, Time, [LH|LT], [RH|RT], Acc) ->
    if
        LH >= Time + 1 andalso RH >= Time + 1 ->
            find_good_days_iter_sliced(CurrentIndex + 1, Time, LT, RT, [CurrentIndex|Acc]);
        true ->
            find_good_days_iter_sliced(CurrentIndex + 1, Time, LT, RT, Acc)
    end.