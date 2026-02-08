-module(leetcode_provinces).
-export([find_circle_memo/1]).

find_circle_memo(Matrix) ->
    N = length(Matrix),
    Visited = lists:duplicate(N, false),
    Count = 0,
    find_circle_memo(Matrix, Visited, Count, 0).

find_circle_memo(_Matrix, _Visited, Count, N) when N == length(_Matrix) ->
    Count;
find_circle_memo(Matrix, Visited, Count, I) ->
    case lists:nth(I + 1, Visited) of
        true -> find_circle_memo(Matrix, Visited, Count, I + 1);
        false ->
            dfs(Matrix, Visited, I, I),
            find_circle_memo(Matrix, Visited, Count + 1, I + 1)
    end.

dfs(_Matrix, _Visited, _I, _J) when _J >= length(_Matrix) ->
    ok;
dfs(Matrix, Visited, I, J) ->
    case lists:nth(J + 1, Visited) of
        true -> dfs(Matrix, Visited, I, J + 1);
        false ->
            case lists:nth(J + 1, lists:nth(I + 1, Matrix)) of
                1 ->
                    NewVisited = lists:sublist(Visited, J) ++ [true] ++ lists:nthtail(J + 1, Visited),
                    dfs(Matrix, NewVisited, I, J + 1);
                _ -> dfs(Matrix, Visited, I, J + 1)
            end
    end.