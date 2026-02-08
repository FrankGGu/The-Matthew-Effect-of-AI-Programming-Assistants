-module(solution).
-export([highest_peak/1]).

highest_peak(IsWater) ->
    {Rows, Cols} = {length(IsWater), length(hd(IsWater))},
    Queue = queue:new(),
    Grid = lists:map(fun(Row) ->
        lists:map(fun(Cell) ->
            case Cell of
                1 -> {0, queue:in({0, 0}, Queue)};
                0 -> {-1, Queue}
            end
        end, Row)
    end, IsWater),
    {FinalGrid, _} = bfs(Grid, Queue, Rows, Cols),
    lists:map(fun(Row) ->
        lists:map(fun({Height, _}) -> Height end, Row)
    end, FinalGrid).

bfs(Grid, Queue, Rows, Cols) ->
    case queue:is_empty(Queue) of
        true -> {Grid, Queue};
        false ->
            {{value, {R, C}}, NewQueue} = queue:out(Queue),
            Neighbors = [{R-1, C}, {R+1, C}, {R, C-1}, {R, C+1}],
            {UpdatedGrid, UpdatedQueue} = lists:foldl(fun({Nr, Nc}, {AccGrid, AccQueue}) ->
                case (Nr >= 0) andalso (Nr < Rows) andalso (Nc >= 0) andalso (Nc < Cols) of
                    true ->
                        Row = lists:nth(Nr + 1, AccGrid),
                        {Height, Q} = lists:nth(Nc + 1, Row),
                        case Height of
                            -1 ->
                                NewHeight = lists:nth(C + 1, lists:nth(R + 1, AccGrid)),
                                NewRow = setelement(Nc + 1, Row, {element(1, NewHeight) + 1, queue:in({Nr, Nc}, Q)}),
                                NewGrid = setelement(Nr + 1, AccGrid, NewRow),
                                {NewGrid, queue:in({Nr, Nc}, AccQueue)};
                            _ ->
                                {AccGrid, AccQueue}
                        end;
                    false ->
                        {AccGrid, AccQueue}
                end
            end, {Grid, NewQueue}, Neighbors),
            bfs(UpdatedGrid, UpdatedQueue, Rows, Cols)
    end.