-spec find_substring_in_wrapround_string(P :: unicode:unicode_binary()) -> integer().
find_substring_in_wrapround_string(P) ->
    S = binary_to_list(P),
    case S of
        [] -> 0;
        _ ->
            DP = lists:duplicate(26, 0),
            {_, NewDP} = lists:foldl(fun(Char, {PrevLen, Acc}) ->
                Index = Char - $a,
                case (PrevLen == 0) orelse ((Char - lists:nth(PrevChar + 1, Acc) == 1) orelse (PrevChar == 25 andalso Char == $a) of
                    true -> 
                        CurrentLen = PrevLen + 1,
                        NewAcc = setelement(Index + 1, Acc, max(CurrentLen, element(Index + 1, Acc))),
                        {CurrentLen, NewAcc};
                    false ->
                        NewAcc = setelement(Index + 1, Acc, max(1, element(Index + 1, Acc))),
                        {1, NewAcc}
                end
            end, {0, DP}, S),
            lists:sum(tuple_to_list(NewDP))
    end.