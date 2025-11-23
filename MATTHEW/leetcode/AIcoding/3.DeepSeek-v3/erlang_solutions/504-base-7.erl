-spec convert_to_base7(integer()) -> unicode:unicode_binary().
convert_to_base7(Num) ->
    case Num of
        0 -> <<"0">>;
        _ -> 
            Sign = if Num < 0 -> "-"; true -> "" end,
            N = abs(Num),
            convert(N, Sign)
    end.

convert(0, Acc) -> list_to_binary(Acc);
convert(N, Acc) ->
    Digit = N rem 7,
    convert(N div 7, [integer_to_list(Digit) | Acc]).