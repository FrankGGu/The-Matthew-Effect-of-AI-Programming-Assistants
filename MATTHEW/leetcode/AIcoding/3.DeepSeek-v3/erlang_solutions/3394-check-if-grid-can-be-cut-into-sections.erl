-module(solution).
-export([can_cut/1]).

can_cut(Grid) ->
    M = length(Grid),
    N = length(hd(Grid)),
    Visited = sets:new(),
    case dfs(0, 0, Grid, Visited, M, N) of
        {true, NewVisited} ->
            Total = lists:sum([lists:sum(Row) || Row <- Grid]),
            sets:size(NewVisited) == Total;
        false ->
            false
    end.

dfs(I, J, Grid, Visited, M, N) ->
    case I >= 0 andalso I < M andalso J >= 0 andalso J < N of
        true ->
            case lists:nth(J + 1, lists:nth(I + 1, Grid)) of
                1 ->
                    case sets:is_element({I, J}, Visited) of
                        false ->
                            NewVisited = sets:add_element({I, J}, Visited),
                            Neighbors = [{I + 1, J}, {I - 1, J}, {I, J + 1}, {I, J - 1}],
                            lists:foldl(fun({X, Y}, Acc) ->
                                                case Acc of
                                                    {true, AccVisited} ->
                                                        dfs(X, Y, Grid, AccVisited, M, N);
                                                    false ->
                                                        false
                                                end
                                        end, {true, NewVisited}, Neighbors);
                        true ->
                            {true, Visited}
                    end;
                0 ->
                    {true, Visited}
            end;
        false ->
            {true, Visited}
    end.