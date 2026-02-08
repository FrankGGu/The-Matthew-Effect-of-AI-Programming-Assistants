-spec min_cost_to_move_chips(Position :: [integer()]) -> integer().
min_cost_to_move_chips(Position) ->
    {Even, Odd} = lists:foldl(fun(P, {E, O}) when P rem 2 == 0 -> {E + 1, O};
                                  (_, {E, O}) -> {E, O + 1} end, {0, 0}, Position),
    min(Even, Odd).