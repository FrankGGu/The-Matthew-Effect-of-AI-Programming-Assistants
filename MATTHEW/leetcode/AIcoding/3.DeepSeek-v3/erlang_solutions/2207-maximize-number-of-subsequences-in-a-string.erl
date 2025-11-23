-solve_max_subsequences(Pattern :: unicode:unicode_binary(), Text :: unicode:unicode_binary()) -> integer().
solve_max_subsequences(Pattern, Text) ->
    <<P1, P2>> = Pattern,
    case P1 =:= P2 of
        true ->
            Count = count_char(Text, P1),
            Count * (Count + 1) div 2;
        false ->
            Count1 = count_char(Text, P1),
            Count2 = count_char(Text, P2),
            case Count1 =:= 0 orelse Count2 =:= 0 of
                true -> 0;
                false ->
                    Total = 0,
                    {Total1, _} = lists:foldl(fun(Char, {Acc, C1}) ->
                        case Char =:= P1 of
                            true -> {Acc, C1 + 1};
                            false -> {Acc + C1, C1}
                        end
                    end, {0, 0}, Text),
                    Total1
            end
    end.

count_char(Text, Char) ->
    lists:foldl(fun(C, Acc) ->
        case C =:= Char of
            true -> Acc + 1;
            false -> Acc
        end
    end, 0, Text).