-module(parallel_courses_ii).
-export([min_number_of_semesters/3]).

min_number_of_semesters(N, Dependencies, K) ->
    Indegree = lists:foldl(fun({_, V}, Acc) -> maps:update(V, fun(X) -> X + 1 end, Acc, 1) end, #{}, Dependencies),
    Graph = lists:foldl(fun({U, V}, Acc) -> maps:update(U, fun(L) -> [V | L] end, Acc, [V]) end, #{}, Dependencies),

    Topo = lists:seq(1, N) -- maps:keys(Indegree),

    memo(Topo, Graph, Indegree, K, #{}).

memo(Topo, Graph, Indegree, K, Memo) ->
    case maps:get(Topo, Memo, undefined) of
        undefined ->
            Result = solve(Topo, Graph, Indegree, K, Memo);
            maps:put(Topo, Result, Memo),
            Result;
        Result ->
            Result
    end.

solve([], _, _, _, _) ->
    0;
solve(Topo, Graph, Indegree, K, Memo) ->
    Ready = [X || X <- Topo, maps:get(X, Indegree, 0) == 0],

    MinSemesters = lists:foldl(fun(Combination, Acc) ->
        NewTopo = Topo -- Combination,
        NewIndegree = lists:foldl(fun(Course, I) ->
            case maps:get(Course, Graph, []) of
                [] -> I;
                Neighbors ->
                    lists:foldl(fun(Neighbor, II) ->
                        maps:update(Neighbor, fun(X) -> X - 1 end, II)
                    end, I, Neighbors)
            end
        end, Indegree, Combination),

        1 + memo(NewTopo, Graph, NewIndegree, K, Memo)
    end, infinity, combinations(Ready, K)),
    MinSemesters.

combinations([], _) -> [[]];
combinations(List, K) ->
    combinations_helper(List, K, []).

combinations_helper([], 0, Acc) -> [lists:reverse(Acc)];
combinations_helper([], _, _) -> [];
combinations_helper(_, 0, Acc) -> [lists:reverse(Acc)];
combinations_helper([H | T], K, Acc) ->
    combinations_helper(T, K - 1, [H | Acc]) ++ combinations_helper(T, K, Acc).

combinations(List, K) when K > length(List) ->
    [List];
combinations(List, K) ->
    lists:usort([X || X <- combinations_helper(List, math:min(K, length(List)), []), length(X) > 0]).