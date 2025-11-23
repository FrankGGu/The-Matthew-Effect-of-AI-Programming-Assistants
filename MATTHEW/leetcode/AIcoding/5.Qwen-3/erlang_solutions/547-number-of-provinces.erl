-module(number_of_provinces).
-export([find_circle_memo/1]).

find_circle_memo(Graph) ->
    N = length(Graph),
    Visited = lists:duplicate(N, false),
    Count = 0,
    find_circle_memo(Graph, Visited, Count, 0).

find_circle_memo(_, _, Count, N) when N >= length(Graph) ->
    Count;
find_circle_memo(Graph, Visited, Count, I) ->
    case lists:nth(I + 1, Visited) of
        true ->
            find_circle_memo(Graph, Visited, Count, I + 1);
        false ->
            dfs(Graph, Visited, I, I),
            find_circle_memo(Graph, Visited, Count + 1, I + 1)
    end.

dfs(_, Visited, _, J) when J >= length(Visited) ->
    ok;
dfs(Graph, Visited, I, J) ->
    case lists:nth(J + 1, Visited) of
        true ->
            dfs(Graph, Visited, I, J + 1);
        false ->
            NewVisited = lists:sublist(Visited, J) ++ [true] ++ lists:nthtail(J + 1, Visited),
            case lists:nth(J + 1, Graph) of
                Row ->
                    case lists:nth(I + 1, Row) of
                        1 ->
                            dfs(Graph, NewVisited, I, J + 1);
                        _ ->
                            dfs(Graph, NewVisited, I, J + 1)
                    end
            end
    end.