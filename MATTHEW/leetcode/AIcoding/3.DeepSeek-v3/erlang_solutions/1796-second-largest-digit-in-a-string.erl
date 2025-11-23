-spec second_highest(S :: unicode:unicode_binary()) -> integer().
second_highest(S) ->
    Digits = lists:filter(fun(C) -> C >= $0 andalso C =< $9 end, binary_to_list(S)),
    UniqueDigits = lists:usort(Digits),
    case length(UniqueDigits) of
        N when N < 2 -> -1;
        _ -> lists:nth(length(UniqueDigits) - 1, UniqueDigits) - $0
    end.