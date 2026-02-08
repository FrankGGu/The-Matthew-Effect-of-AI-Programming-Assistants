-module(solution).
-export([contains_cycle/1]).

contains_cycle(Grid) ->
    GridList = lists:map(fun(Row) -> lists:map(fun(X) -> {Row, X} end, lists:seq(1, length(Row))) end, lists:seq(1, length(Grid))),
    Visited = lists:foldl(fun(_, Acc) -> lists:append(Acc, [false]) end, [], GridList),
    lists:foldl(fun(X, Acc) -> Acc oralso dfs(Grid, X, X, Visited) end, false, GridList).

dfs(_, {R, C}, {PR, PC}, Visited) ->
    case lists:nth(R, lists:nth(C, Visited)) of
        true -> false;
        false -> 
            Visited1 = lists:replace(R, lists:replace(C, true, lists:nth(C, lists:nth(R, Visited))), Visited),
            Directions = [{0,1}, {1,0}, {0,-1}, {-1,0}],
            lists:foldl(fun({DR, DC}, Acc) ->
                NR = R + DR,
                NC = C + DC,
                case is_valid(NR, NC, Visited, Grid) of
                    true -> 
                        if
                            {NR, NC} =:= {PR, PC} -> Acc;
                            dfs(Grid, {NR, NC}, {R, C}, Visited1) -> true;
                            true -> Acc
                        end;
                    false -> Acc
                end
            end, false, Directions)
    end.

is_valid(R, C, Visited, Grid) ->
    R > 0, R =< length(Grid),
    C > 0, C =< length(lists:nth(R, Grid)),
    not lists:nth(C, lists:nth(R, Visited)),
    lists:nth(C, lists:nth(R, Grid)) == lists:nth(C, lists:nth(1, Grid)).