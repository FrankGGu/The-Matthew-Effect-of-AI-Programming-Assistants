-spec longest_balanced_substring(S :: unicode:unicode_binary()) -> integer().
longest_balanced_substring(S) ->
    S1 = binary_to_list(S),
    Max = 0,
    Count0 = 0,
    Count1 = 0,
    lists:foldl(fun
        ($0, {MaxAcc, C0, C1}) ->
            NewC0 = C0 + 1,
            {max(MaxAcc, 2 * min(NewC0, C1)), NewC0, C1};
        ($1, {MaxAcc, C0, C1}) ->
            NewC1 = C1 + 1,
            {max(MaxAcc, 2 * min(C0, NewC1)), C0, NewC1}
    end, {Max, Count0, Count1}, S1).