-module(solution).
-export([min_flips/1]).

min_flips(Mat) ->
    M = length(Mat),
    N = length(hd(Mat)),
    Target = 0,
    Visited = sets:new(),
    Queue = queue:from_list([{Mat, 0}]),
    bfs(Queue, Visited, M, N, Target).

bfs(Queue, Visited, M, N, Target) ->
    case queue:out(Queue) of
        {empty, _} -> -1;
        {{value, {CurrentMat, Steps}}, NewQueue} ->
            case is_zero(CurrentMat, M, N, Target) of
                true -> Steps;
                false ->
                    case sets:is_element(CurrentMat, Visited) of
                        true -> bfs(NewQueue, Visited, M, N, Target);
                        false ->
                            NewVisited = sets:add_element(CurrentMat, Visited),
                            NextMats = generate_next(CurrentMat, M, N),
                            UpdatedQueue = lists:foldl(fun(NextMat, Q) ->
                                queue:in({NextMat, Steps + 1}, Q)
                            end, NewQueue, NextMats),
                            bfs(UpdatedQueue, NewVisited, M, N, Target)
                    end
            end
    end.

is_zero(Mat, M, N, Target) ->
    lists:all(fun(Row) ->
        lists:all(fun(X) -> X =:= Target end, Row)
    end, Mat).

generate_next(Mat, M, N) ->
    NextMats = [],
    lists:foldl(fun(I, Acc1) ->
        lists:foldl(fun(J, Acc2) ->
            Flipped = flip(Mat, I, J, M, N),
            [Flipped | Acc2]
        end, Acc1, lists:seq(0, N - 1))
    end, NextMats, lists:seq(0, M - 1)).

flip(Mat, I, J, M, N) ->
    NewMat = lists:map(fun(Row) -> Row end, Mat),
    flip_cell(NewMat, I, J),
    flip_cell(NewMat, I - 1, J),
    flip_cell(NewMat, I + 1, J),
    flip_cell(NewMat, I, J - 1),
    flip_cell(NewMat, I, J + 1),
    NewMat.

flip_cell(Mat, I, J) ->
    case (I >= 0) and (I < length(Mat)) and (J >= 0) and (J < length(hd(Mat))) of
        true ->
            Row = lists:nth(I + 1, Mat),
            NewRow = list_update(Row, J + 1, 1 - lists:nth(J + 1, Row)),
            lists:sublist(Mat, I) ++ [NewRow] ++ lists:nthtail(I + 1, Mat);
        false -> Mat
    end.

list_update(List, Pos, Value) ->
    lists:sublist(List, Pos - 1) ++ [Value] ++ lists:nthtail(Pos, List).