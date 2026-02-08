-module(solution).
-export([can_partition/1]).

can_partition(Grid) ->
    N = length(Grid),
    M = length(hd(Grid)),
    TotalSum = lists:sum(lists:map(fun(Row) -> lists:sum(Row) end, Grid)),
    if TotalSum rem 2 =:= 0 ->
        Target = TotalSum div 2,
        can_partition_helper(Grid, N, M, Target, []);
    true -> false
    end.

can_partition_helper(Grid, N, M, Target, Visited) ->
    if Target =:= 0 -> 
        true;
       Target < 0 -> 
        false;
       true ->
        case find_unvisited(Grid, N, M, Visited) of
            none -> false;
            {I, J} ->
                NewVisited = [{I, J} | Visited],
                can_partition_helper(Grid, N, M, Target - Grid[I][J], NewVisited) orelse
                can_partition_helper(Grid, N, M, Target, NewVisited)
        end
    end.

find_unvisited(Grid, N, M, Visited) ->
    lists:foldl(fun({I, J}, Acc) ->
        if lists:member({I, J}, Visited) -> 
            Acc;
        true -> 
            {I, J}
        end
    end, none, lists:seq(0, N - 1) ++ lists:seq(0, M - 1)).