-spec strong_password_checker(Password :: unicode:unicode_binary()) -> integer().
strong_password_checker(Password) ->
    N = byte_size(Password),
    HasLower = lists:any(fun(C) -> C >= $a andalso C =< $z end, binary_to_list(Password)),
    HasUpper = lists:any(fun(C) -> C >= $A andalso C =< $Z end, binary_to_list(Password)),
    HasDigit = lists:any(fun(C) -> C >= $0 andalso C =< $9 end, binary_to_list(Password)),
    MissingTypes = (if not HasLower -> 1; true -> 0 end) + (if not HasUpper -> 1; true -> 0 end) + (if not HasDigit -> 1; true -> 0 end),
    Replace = 0,
    OneSeq = 0,
    TwoSeq = 0,
    {Replace1, OneSeq1, TwoSeq1} = count_repeats(Password, 0, Replace, OneSeq, TwoSeq),
    if
        N < 6 ->
            max(6 - N, MissingTypes);
        N =< 20 ->
            max(Replace1, MissingTypes);
        true ->
            Delete = N - 20,
            Replace2 = max(Replace1 - Delete, 0),
            OneSeq2 = max(OneSeq1 - min(Delete, OneSeq1 * 1),
            TwoSeq2 = max(TwoSeq1 - min(max(Delete - OneSeq1, 0) div 2, TwoSeq1),
                          max(TwoSeq1 - (Delete - OneSeq1 + 1) div 2, 0)),
            Replace3 = max(Replace2 - (max(Delete - OneSeq1 - TwoSeq1 * 2, 0) div 3), 0),
            Delete + max(Replace3, MissingTypes)
    end.

count_repeats(<<>>, _, Replace, OneSeq, TwoSeq) ->
    {Replace, OneSeq, TwoSeq};
count_repeats(<<C, Rest/binary>>, Count, Replace, OneSeq, TwoSeq) ->
    case Rest of
        <<C, _/binary>> ->
            count_repeats(Rest, Count + 1, Replace, OneSeq, TwoSeq);
        _ ->
            if
                Count >= 2 ->
                    NewReplace = Replace + (Count div 3),
                    NewOneSeq = OneSeq + case Count rem 3 of 0 -> 1; _ -> 0 end,
                    NewTwoSeq = TwoSeq + case Count rem 3 of 1 -> 1; _ -> 0 end,
                    count_repeats(Rest, 0, NewReplace, NewOneSeq, NewTwoSeq);
                true ->
                    count_repeats(Rest, 0, Replace, OneSeq, TwoSeq)
            end
    end.