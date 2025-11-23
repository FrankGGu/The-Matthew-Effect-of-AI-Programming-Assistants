-spec minimum_partition(S :: unicode:unicode_binary(), K :: integer()) -> integer().
minimum_partition(S, K) ->
    SList = unicode:characters_to_list(S),
    {Ans, _} = lists:foldl(fun(Char, {Count, Current}) ->
        Digit = Char - $0,
        NewCurrent = Current * 10 + Digit,
        if
            NewCurrent > K ->
                if
                    Digit > K -> { -1, 0 };
                    true -> {Count + 1, Digit}
                end;
            true -> {Count, NewCurrent}
        end
    end, {1, 0}, SList),
    Ans.