-spec min_max_game(Nums :: [integer()]) -> integer().
min_max_game(Nums) ->
    case Nums of
        [X] -> X;
        _ ->
            NewNums = lists:map(fun({I, _}) ->
                case I rem 2 of
                    0 -> min(lists:nth(I, Nums), lists:nth(I + 1, Nums));
                    1 -> max(lists:nth(I, Nums), lists:nth(I + 1, Nums))
                end
            end, lists:zip(lists:seq(1, length(Nums) div 2), lists:seq(1, length(Nums) div 2))),
            min_max_game(NewNums)
    end.