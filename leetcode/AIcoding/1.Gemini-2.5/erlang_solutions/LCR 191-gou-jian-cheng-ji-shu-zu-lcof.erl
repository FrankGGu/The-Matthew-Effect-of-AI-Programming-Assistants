-module(solution).
-export([find_champion/1]).

-spec find_champion(Grid :: [[integer()]]) -> integer().
find_champion(Grid) ->
    N = length(Grid),
    lists:foldl(fun(I, Acc) ->
        case Acc of
            -1 ->
                TeamIRow = lists:nth(I + 1, Grid),
                IsChampion = lists:all(fun(J) ->
                    if
                        I == J ->
                            true;
                        true ->
                            lists:nth(J + 1, TeamIRow) == 1
                    end
                end, lists:seq(0, N - 1)),
                if
                    IsChampion -> I;
                    true -> -1
                end;
            _ -> Acc
        end
    end, -1, lists:seq(0, N - 1)).