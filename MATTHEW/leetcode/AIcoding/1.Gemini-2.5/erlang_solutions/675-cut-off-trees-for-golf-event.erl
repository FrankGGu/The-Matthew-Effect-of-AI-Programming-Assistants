-module(solution).
-export([cutOffTree/1]).

cutOffTree(ForestList) ->
    M = length(ForestList),
    N = length(hd(ForestList)),
    Forest = list_to_array_of_arrays(ForestList, M, N),
    Trees = collect_trees(Forest, M, N),
    SortedTrees = lists:sort(fun({{V1,_,_}}, {{V2,_,_}}) -> V1 < V2 end, Trees),
    solve(Forest, M, N, {0,0}, 0, SortedTrees).

solve(_Forest, _M, _N, _CurrentPos, TotalSteps, []) ->
    TotalSteps;
solve(Forest, M, N, CurrentPos, TotalSteps, [{{_Val, TR, TC}} | RestTrees]) ->
    Steps = bfs(Forest, M, N, CurrentPos, {TR, TC}),
    case Steps of
        -1 -> -1;
        _ -> solve(Forest, M, N, {TR, TC}, TotalSteps + Steps, RestTrees)
    end.

collect_trees(Forest, M, N) ->
    lists:foldl(fun(R, AccR) ->
        lists:foldl(fun(C, AccC) ->
            Val = array:get(C, array:get(R, Forest)),
            if Val > 1 -> AccC ++ [{{Val, R, C}}];
               true -> AccC
            end
        end, AccR, lists:seq(0, N - 1))
    end, [], lists:seq(0, M - 1)).

bfs(Forest, M, N, StartPos, EndPos) ->
    if StartPos == EndPos -> 0;
       true ->
            try
                Queue = queue:in({StartPos, 0}, queue:new()),
                Visited = sets:add_element(StartPos, sets:new()),
                bfs_loop(Forest, M, N, EndPos, Queue, Visited)
            catch
                {found, Steps} -> Steps
            end
    end.

bfs_loop(_Forest, _M, _N, _EndPos, Queue, _Visited) when queue:is_empty(Queue) ->
    -1;
bfs_loop(Forest, M, N, EndPos, Queue, Visited) ->
    {{value, {{CR, CC}, Steps}}, NewQueue} = queue:out(Queue),
    Neighbors = get_neighbors(CR, CC),
    {NextQueue, NextVisited} = lists:foldl(fun({NR, NC}, {AccQ, AccV}) ->
        if is_valid(M, N, NR, NC) andalso get_val_array(Forest, NR, NC) /= 0 andalso not sets:is_element({NR, NC}, AccV) ->
            if {NR, NC} == EndPos ->
                throw({found, Steps + 1});
            true ->
                {queue:in({{NR, NC}, Steps + 1}, AccQ), sets:add_element({NR, NC}, AccV)}
            end;
           true ->
            {AccQ, AccV}
        end
    end, {NewQueue, Visited}, Neighbors),
    bfs_loop(Forest, M, N, EndPos, NextQueue, NextVisited).

get_val_array(Forest, R, C) ->
    array:get(C, array:get(R, Forest)).

is_valid(M, N, R, C) ->
    R >= 0 andalso R < M andalso C >= 0 andalso C < N.

get_neighbors(R, C) ->
    [{{R - 1, C}}, {{R + 1, C}}, {{R, C - 1}}, {{R, C + 1}}].

list_to_array_of_arrays(ForestList, _M, _N) ->
    Rows = lists:map(fun(RowList) ->
        array:from_list(RowList)
    end, ForestList),
    array:from_list(Rows).