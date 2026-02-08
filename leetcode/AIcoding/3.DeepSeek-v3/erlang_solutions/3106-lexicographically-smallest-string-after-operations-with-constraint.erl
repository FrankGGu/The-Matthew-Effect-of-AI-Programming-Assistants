-spec smallest_string(S :: unicode:unicode_binary(), K :: integer()) -> unicode:unicode_binary().
smallest_string(S, K) ->
    SList = unicode:characters_to_list(S),
    Result = smallest_string_helper(SList, K, 0, []),
    unicode:characters_to_binary(Result).

smallest_string_helper([], _, _, Acc) ->
    lists:reverse(Acc);
smallest_string_helper([H | T], K, I, Acc) ->
    case find_smallest_char(H, K) of
        H ->
            smallest_string_helper(T, K, I + 1, [H | Acc]);
        Smallest ->
            NewStr = lists:reverse(Acc) ++ [Smallest] ++ lists:duplicate(I, $a) ++ T,
            lists:min([smallest_string_helper(T, K, I + 1, [H | Acc]), NewStr])
    end.

find_smallest_char(Char, K) ->
    MinChar = max($a, Char - K),
    case MinChar of
        $a -> $a;
        _ -> MinChar
    end.