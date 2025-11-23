-spec detect_capital_use(Word :: unicode:unicode_binary()) -> boolean().
detect_capital_use(Word) ->
    case binary:bin_to_list(Word) of
        [] -> true;
        [First | Rest] ->
            AllUpper = lists:all(fun(C) -> C >= $A andalso C =< $Z end, [First | Rest]),
            AllLower = lists:all(fun(C) -> C >= $a andalso C =< $z end, [First | Rest]),
            FirstUpper = (First >= $A andalso First =< $Z) andalso 
                         lists:all(fun(C) -> C >= $a andalso C =< $z end, Rest),
            AllUpper orelse AllLower orelse FirstUpper
    end.