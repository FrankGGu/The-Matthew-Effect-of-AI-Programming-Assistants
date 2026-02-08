is_valid(S) ->
    Stack = [],
    lists:foldl(fun
        (Char, Acc) ->
            case {Char, Acc} of
                {$(, _} -> [$( | Acc];
                {$[, _} -> [$[ | Acc];
                ${, _} -> [${ | Acc];
                {$), [$( | Rest]} -> Rest;
                {$], [$[ | Rest]} -> Rest;
                {$}, [${ | Rest]} -> Rest;
                _ -> [invalid | Acc]
            end
        end, Stack, S) == [].