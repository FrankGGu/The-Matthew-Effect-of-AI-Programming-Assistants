-spec largest_palindromic(Num :: unicode:unicode_binary()) -> unicode:unicode_binary().
largest_palindromic(Num) ->
    Freq = count_frequency(Num),
    {Left, Mid, Freq1} = build_half(Freq),
    Right = lists:reverse(Left),
    Result = case Mid of
        none -> Left ++ Right;
        _ -> Left ++ [Mid] ++ Right
    end,
    case Result of
        [] -> <<"0">>;
        _ -> 
            case string:strip(unicode:characters_to_list(Result), left, $0) of
                [] -> <<"0">>;
                Stripped -> unicode:characters_to_binary(Stripped)
            end
    end.

count_frequency(Num) ->
    lists:foldl(fun(Char, Acc) ->
        maps:update_with(Char, fun(V) -> V + 1 end, 1, Acc)
    end, #{}, unicode:characters_to_list(Num)).

build_half(Freq) ->
    maps:fold(fun(Char, Count, {Left, Mid, FreqAcc}) ->
        case Count div 2 of
            0 -> {Left, Mid, FreqAcc};
            HalfCount ->
                NewLeft = lists:duplicate(HalfCount, Char) ++ Left,
                NewFreqAcc = case Count rem 2 of
                    0 -> FreqAcc;
                    1 -> maps:put(Char, 1, FreqAcc)
                end,
                {NewLeft, Mid, NewFreqAcc}
        end
    end, {[], none, #{}}, Freq).