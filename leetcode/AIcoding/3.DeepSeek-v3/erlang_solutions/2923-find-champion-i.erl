-spec find_champion(Grid :: [[integer()]]) -> integer().
find_champion(Grid) ->
    N = length(Grid),
    lists:foldl(
        fun(I, Champion) ->
            case lists:all(fun(J) -> I =:= J orelse lists:nth(I + 1, lists:nth(J + 1, Grid)) =:= 1 end, lists:seq(0, N - 1)) of
                true -> I;
                false -> Champion
            end
        end,
        -1,
        lists:seq(0, N - 1)
    ).