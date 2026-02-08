-spec largest_odd_number(Num :: unicode:unicode_binary()) -> unicode:unicode_binary().
largest_odd_number(Num) ->
    case binary:last(Num) rem 2 of
        1 -> Num;
        _ -> largest_odd_number(binary:part(Num, 0, byte_size(Num) - 1))
    end.