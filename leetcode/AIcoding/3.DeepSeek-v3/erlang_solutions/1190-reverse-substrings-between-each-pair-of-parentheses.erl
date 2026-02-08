-spec reverse_parentheses(S :: unicode:unicode_binary()) -> unicode:unicode_binary().
reverse_parentheses(S) ->
    Stack = [[]],
    lists:foldl(fun
        ($(, Acc) -> [[] | Acc];
        ($), Acc) -> 
            [Top | Rest] = Acc,
            Reversed = lists:reverse(Top),
            case Rest of
                [Next | Others] -> [[Next ++ Reversed] | Others];
                [] -> [Reversed]
            end;
        (Char, [Top | Rest]) -> [[Top ++ [Char]] | Rest]
    end, Stack, S),
    hd(hd(Stack)).