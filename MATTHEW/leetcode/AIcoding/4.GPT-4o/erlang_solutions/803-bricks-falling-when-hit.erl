-module(sol).
-export([hit_bricks/3]).

hit_bricks(Hits, Grid, N) ->
    {Res, _} = hit_bricks(Hits, Grid, N, length(Grid), length(lists:nth(1, Grid))).

hit_bricks([], _, _, _Rows, _Cols) -> [];
hit_bricks([{X, Y} | Rest], Grid, N, Rows, Cols) ->
    NewGrid = lists:map(fun(Row, I) -> if I =:= X -> lists:replace_element(Y, 1, Row); true -> Row end end, Grid, lists:seq(0, Rows - 1)),
    if is_connected(NewGrid, Rows, Cols) -> 
        NewCount = count_connected_bricks(NewGrid, Rows, Cols),
        [NewCount - N | hit_bricks(Rest, NewGrid, NewCount, Rows, Cols)]; 
    true -> 
        [0 | hit_bricks(Rest, NewGrid, N, Rows, Cols)]
    end.

is_connected(Grid, Rows, Cols) ->
    Visited = lists:duplicate(Rows, lists:duplicate(Cols, false)),
    lists:foldl(fun({I, J}, Acc) -> 
        if lists:nth(I + 1, Acc) =:= false -> 
            Acc; 
        true -> 
            lists:replace_element(I, lists:replace_element(J, true, lists:nth(I, Acc)), Acc)
        end 
    end, Visited, connected_bricks(Grid, Rows, Cols)).

connected_bricks(Grid, Rows, Cols) ->
    lists:flatmap(fun(I) -> lists:flatmap(fun(J) -> if lists:nth(J, lists:nth(I, Grid)) =:= 1 -> [{I, J}]; true -> [] end end, lists:seq(0, Cols - 1)) end, lists:seq(0, Rows - 1)).

count_connected_bricks(Grid, Rows, Cols) ->
    lists:sum(lists:map(fun(Row) -> lists:sum(Row) end, Grid)).

lists:replace_element(Index, NewValue, List) ->
    lists:map(fun({Val, Idx}) -> if Idx =:= Index -> NewValue; true -> Val end end, lists:zip(List, lists:seq(0, length(List) - 1))).