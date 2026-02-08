-module(solution).
-export([numDupDigitsAtMostN/1]).

numDupDigitsAtMostN(N) ->
    N - count_unique_digits_at_most_N(N).

count_unique_digits_at_most_N(N) ->
    N_str = integer_to_list(N),
    Len = length(N_str),
    Digits = [D - $0 || D <- N_str],

    TotalUniqueCount1 = count_fewer_digits_sum(1, Len - 1, 0),
    TotalUniqueCount2 = count_same_digits_prefix(Digits, Len, sets:new(), 0, 0),

    TotalUniqueCount1 + TotalUniqueCount2.

count_fewer_digits_sum(K, EndK, Acc) when K > EndK ->
    Acc;
count_fewer_digits_sum(K, EndK, Acc) ->
    Perms = 9 * permutations(9, K - 1),
    count_fewer_digits_sum(K + 1, EndK, Acc + Perms).

permutations(N, K) ->
    permutations(N, K, 1).

permutations(_N, 0, Acc) ->
    Acc;
permutations(N, K, _Acc) when N < K ->
    0;
permutations(N, K, Acc) ->
    permutations(N - 1, K - 1, Acc * N).

count_same_digits_prefix(Digits, Len, UsedDigits, Index, Acc) ->
    if Index == Len ->
        Acc + 1
    else
        CurrentDigit = lists:nth(Index + 1, Digits),

        StartDigit = if Index == 0 -> 1;
                       true -> 0
                     end,

        AccAfterSmallerDigits = count_smaller_at_pos(StartDigit, CurrentDigit - 1, UsedDigits, Len - 1 - Index, Acc),

        if sets:is_element(CurrentDigit, UsedDigits) ->
            AccAfterSmallerDigits
        else
            NewUsedDigits = sets:add_element(CurrentDigit, UsedDigits),
            count_same_digits_prefix(Digits, Len, NewUsedDigits, Index + 1, AccAfterSmallerDigits)
        end
    end.

count_smaller_at_pos(D, MaxD, UsedDigits, RemainingSlots, Acc) when D > MaxD ->
    Acc;
count_smaller_at_pos(D, MaxD, UsedDigits, RemainingSlots, Acc) ->
    if not sets:is_element(D, UsedDigits) ->
        AvailableDigitsForSuffix = 10 - (sets:size(UsedDigits) + 1),
        Perms = permutations(AvailableDigitsForSuffix, RemainingSlots),
        count_smaller_at_pos(D + 1, MaxD, UsedDigits, RemainingSlots, Acc + Perms)
    else
        count_smaller_at_pos(D + 1, MaxD, UsedDigits, RemainingSlots, Acc)
    end.