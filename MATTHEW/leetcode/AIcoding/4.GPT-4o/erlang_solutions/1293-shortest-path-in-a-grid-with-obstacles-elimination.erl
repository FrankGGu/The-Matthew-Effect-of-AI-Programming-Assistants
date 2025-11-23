-module(solution).

-export([shortest_path/3]).

shortest_path(Grid, k, Start, End) ->
    Rows = length(Grid),
    Cols = length(hd(Grid)),
    StartPos = {element(1, Start), element(2, Start)},
    EndPos = {element(1, End), element(2, End)},
    bfs([{StartPos, k, 0}], EndPos, Rows, Cols, Grid, 0).

bfs([], _End, _Rows, _Cols, _Grid, _MinDist) -> -1;
bfs([{Pos, RemainingK, Dist} | Rest], EndPos, Rows, Cols, Grid, MinDist) ->
    if
        Pos =:= EndPos -> Dist;
        RemainingK < 0 -> bfs(Rest, EndPos, Rows, Cols, Grid, MinDist);
        true ->
            {X, Y} = Pos,
            Neighbors = [{X + 1, Y}, {X - 1, Y}, {X, Y + 1}, {X, Y - 1}],
            NewStates = lists:filter(fun({NX, NY}) -> 
                NX >= 1, NX =< Rows, NY >= 1, NY =< Cols 
                andalso not visited(Pos, RemainingK, Rest, Grid, NX, NY)
            end, Neighbors),
            NewStateList = lists:map(fun(N) ->
                {N, RemainingK - (element(1, lists:nth(element(1, N), Grid)) == 1), Dist + 1}
            end, NewStates),
            bfs(Rest ++ NewStateList, EndPos, Rows, Cols, Grid, MinDist)
    end.

visited(Pos, RemainingK, Rest, Grid, NX, NY) ->
    case lists:keyfind({NX, NY}, 1, Rest) of
        false -> false;
        {_, RK, _} -> RK >= RemainingK
    end.