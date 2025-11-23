-spec largest_good_integer(Num :: unicode:unicode_binary()) -> unicode:unicode_binary().
largest_good_integer(Num) ->
    case binary_to_list(Num) of
        [] -> <<>>;
        [_] -> <<>>;
        [_, _] -> <<>>;
        L -> 
            find_largest(L, -1, 0)
    end.

find_largest([A, B, C | T], Max, _) when A =:= B, B =:= C ->
    Current = (A - $0) * 100 + (B - $0) * 10 + (C - $0),
    NewMax = max(Max, Current),
    find_largest([B, C | T], NewMax, 1);
find_largest([_ | T], Max, Found) ->
    find_largest(T, Max, Found);
find_largest(_, Max, Found) ->
    case Found of
        0 -> <<>>;
        _ -> 
            Digit = Max div 100 + $0,
            <<Digit, Digit, Digit>>
    end.