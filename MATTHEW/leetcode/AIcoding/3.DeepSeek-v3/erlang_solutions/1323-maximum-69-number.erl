-spec maximum69_number(Num :: integer()) -> integer().
maximum69_number(Num) ->
    List = integer_to_list(Num),
    {Prefix, Suffix} = lists:splitwith(fun(C) -> C =/= $6 end, List),
    case Suffix of
        [] -> Num;
        _ -> list_to_integer(Prefix ++ "9" ++ tl(Suffix))
    end.