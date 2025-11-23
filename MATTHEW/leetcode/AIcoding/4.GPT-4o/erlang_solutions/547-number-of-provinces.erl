-module(solution).
-export([findCircleNum/1]).

findCircleNum(M) ->
    N = length(M),
    Visited = lists:duplicate(N, false),
    Count = find_provinces(M, Visited, 0, N),
    Count.

find_provinces(_, Visited, Count, N) when Count == N -> Count;
find_provinces(M, Visited, Count, N) ->
    case lists:find(fun(X) -> not lists:nth(X + 1, Visited) end, lists:seq(0, N - 1)) of
        none -> Count;
        {ok, i} ->
            Visited1 = visit(M, Visited, i),
            find_provinces(M, Visited1, Count + 1, N)
    end.

visit(M, Visited, i) ->
    case lists:nth(i + 1, Visited) of
        true -> Visited;
        false ->
            Visited1 = lists:replace(i + 1, true, Visited),
            lists:foldl(fun(j, Acc) ->
                if 
                    lists:nth(i + 1, M) =:= 1 andalso not lists:nth(j + 1, Acc) -> 
                        visit(M, Acc, j)
                end
            end, Visited1, lists:seq(0, length(M) - 1))
    end.