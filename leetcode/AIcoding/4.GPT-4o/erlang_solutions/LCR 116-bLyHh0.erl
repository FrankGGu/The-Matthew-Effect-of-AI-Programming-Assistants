-module(solution).
-export([findCircleNum/1]).

findCircleNum(M) ->
    N = length(M),
    Visited = lists:duplicate(N, false),
    count_provinces(M, Visited, N, 0).

count_provinces(_, Visited, N, Count) when Count == N ->
    Count;
count_provinces(M, Visited, N, Count) ->
    {NewVisited, NewCount} = visit_province(M, Visited, Count),
    count_provinces(M, NewVisited, N, NewCount + 1).

visit_province(M, Visited, I) ->
    case lists:nth(I + 1, Visited) of
        true -> {Visited, I};
        false ->
            NewVisited = lists:replace(I + 1, true, Visited),
            lists:foldl(fun(J, Acc) ->
                if
                    M[I][J] =:= 1 andalso not lists:nth(J + 1, Acc) ->
                        visit_province(M, Acc, J);
                    true ->
                        Acc
                end
            end, NewVisited, lists:seq(0, length(M) - 1))
    end.