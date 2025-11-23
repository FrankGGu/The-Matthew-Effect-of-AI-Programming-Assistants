-spec count_even_numbers([integer()]) -> integer().
count_even_numbers(Digits) ->
    UniqueDigits = lists:usort(Digits),
    count(UniqueDigits, 0, 0).

count(_, 3, Num) ->
    case Num rem 2 of
        0 -> 1;
        _ -> 0
    end;
count(Digits, Length, Num) when Length < 3 ->
    lists:foldl(fun(D, Acc) ->
        case (Length == 0 andalso D /= 0) orelse Length > 0 of
            true -> Acc + count(Digits, Length + 1, Num * 10 + D);
            false -> Acc
        end
    end, 0, Digits).