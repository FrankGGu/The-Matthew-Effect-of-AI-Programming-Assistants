-spec minimum_cost(S :: unicode:unicode_binary()) -> integer().
minimum_cost(S) ->
    case S of
        <<>> -> 0;
        _ ->
            {Cost, _} = lists:foldl(fun(Char, {AccCost, Stack}) ->
                case Stack of
                    [] -> {AccCost + 1, [Char]};
                    [Top | Rest] when Top =:= Char -> {AccCost, Rest};
                    _ -> {AccCost + 1, [Char | Stack]}
                end
            end, {0, []}, binary_to_list(S)),
            Cost
    end.