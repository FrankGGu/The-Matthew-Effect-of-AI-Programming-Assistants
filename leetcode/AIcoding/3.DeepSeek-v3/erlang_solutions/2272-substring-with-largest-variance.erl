-spec largest_variance(S :: unicode:unicode_binary()) -> integer().
largest_variance(S) ->
    Chars = binary_to_list(S),
    UniqueChars = lists:usort(Chars),
    MaxVariance = 0,
    lists:foldl(fun(A, Acc1) ->
        lists:foldl(fun(B, Acc2) ->
            if
                A =:= B -> Acc2;
                true ->
                    Variance = calculate_variance(Chars, A, B),
                    max(Acc2, Variance)
            end
        end, Acc1, UniqueChars)
    end, MaxVariance, UniqueChars).

calculate_variance(Chars, A, B) ->
    {MaxVariance, CurrentA, CurrentB, HasB} = lists:foldl(fun(Char, {Max, CA, CB, HB}) ->
        if
            Char =:= A ->
                NewCA = CA + 1,
                NewMax = if
                    HB -> max(Max, NewCA - CB);
                    true -> Max
                end,
                {NewMax, NewCA, CB, HB};
            Char =:= B ->
                NewCB = CB + 1,
                NewMax = max(Max, CA - NewCB),
                NewHB = true,
                {NewMax, CA, NewCB, NewHB};
            true ->
                {Max, CA, CB, HB}
        end
    end, {0, 0, 0, false}, Chars),
    MaxVariance.