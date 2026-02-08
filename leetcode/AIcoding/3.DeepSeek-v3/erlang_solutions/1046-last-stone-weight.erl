-spec last_stone_weight(Stones :: [integer()]) -> integer().
last_stone_weight(Stones) ->
    case lists:sort(fun(A, B) -> A >= B end, Stones) of
        [] -> 0;
        [X] -> X;
        [Y, X | Rest] ->
            case Y - X of
                0 -> last_stone_weight(Rest);
                Diff -> last_stone_weight([Diff | Rest])
            end
    end.