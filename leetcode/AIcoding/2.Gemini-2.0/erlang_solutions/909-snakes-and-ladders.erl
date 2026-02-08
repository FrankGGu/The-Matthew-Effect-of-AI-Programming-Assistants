-module(snakes_and_ladders).
-export([snakes_and_ladders/1]).

snakes_and_ladders(board) ->
    N = length(board),
    squares(board, N).

squares(Board, N) ->
    Squares = N * N,
    Dist = array:new([1, Squares + 1], {infinity, 0}),
    array:set(1, Dist, {0, 0}),
    Q = queue:new(),
    queue:in(1, Q) -> {Q1, 1};
    bfs(Board, N, Squares, Dist, Q1).

bfs(Board, N, Squares, Dist, Q) ->
    case queue:out(Q) of
        {empty, _} ->
            -1;
        {{value, Square}, Q1} ->
            {Distance, _} = array:get(Square, Dist),
            NextSquares = lists:seq(Square + 1, min(Square + 6, Squares)),
            lists:foldl(
                fun(NextSquare, AccQ) ->
                    {Row, Col} = get_row_col(NextSquare, N),
                    Next = case lists:nth(Col, lists:nth(Row, Board)) of
                                -1 ->
                                    NextSquare;
                                Other ->
                                    Other
                            end,
                    {NextDistance, _} = array:get(Next, Dist),
                    if
                        NextDistance == infinity ->
                            array:set(Next, Dist, {Distance + 1, 0}),
                            queue:in(Next, AccQ) -> {AccQ2, _};
                            AccQ2
                        ;
                        true ->
                            AccQ
                    end
                end,
                Q1,
                NextSquares
            ),
            case array:get(Squares, Dist) of
                {infinity, _} ->
                    bfs(Board, N, Squares, Dist, Q1);
                {Distance, _} ->
                    Distance
            end
    end.

get_row_col(Square, N) ->
    Row = N - ((Square - 1) div N) - 1,
    ColIndex = (Square - 1) rem N,
    Col = if (N - Row - 1) rem 2 == 0 then
              ColIndex + 1
          else
              N - ColIndex
          end,
    {Row + 1, Col}.