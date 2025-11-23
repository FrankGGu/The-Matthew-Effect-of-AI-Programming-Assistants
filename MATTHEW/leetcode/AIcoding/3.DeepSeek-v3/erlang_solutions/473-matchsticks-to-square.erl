-module(solution).
-export([makesquare/1]).

makesquare(Matchsticks) ->
    case Matchsticks of
        [] -> false;
        _ ->
            Total = lists:sum(Matchsticks),
            case Total rem 4 of
                0 ->
                    Side = Total div 4,
                    Sorted = lists:sort(fun(A, B) -> A > B end, Matchsticks),
                    dfs(Sorted, Side, [0, 0, 0, 0], 0);
                _ -> false
            end
    end.

dfs([], Side, [Side, Side, Side, Side], _) -> true;
dfs([H | T], Side, Sides, Index) when Index < 4 ->
    Current = lists:nth(Index + 1, Sides),
    if
        Current + H =< Side ->
            NewSides = setelement(Index + 1, list_to_tuple(Sides), Current + H),
            case dfs(T, Side, tuple_to_list(NewSides), 0) of
                true -> true;
                false -> dfs([H | T], Side, Sides, Index + 1)
            end;
        true ->
            dfs([H | T], Side, Sides, Index + 1)
    end;
dfs(_, _, _, _) -> false.