-module(solution).
-export([diagonal_difference/1]).

diagonal_difference(Grid) ->
    N = length(Grid),
    M = length(hd(Grid)),
    Map = maps:from_list([{ {I, J}, element(J + 1, lists:nth(I + 1, Grid)) } || I <- lists:seq(0, N - 1), J <- lists:seq(0, M - 1)]),

    Result = [[ count_distinct_diag(I, J, N, M, Map) || J <- lists:seq(0, M - 1)] || I <- lists:seq(0, N - 1)],
    Result.

count_distinct_diag(Row, Col, N, M, Map) ->
    TopLeftToBottomRight = sets:new(),
    TopRightToBottomLeft = sets:new(),
    TopLeftToBottomRightSet = add_diagonal(Row, Col, 1, 1, N, M, Map, TopLeftToBottomRight),
    TopRightToBottomLeftSet = add_diagonal(Row, Col, 1, -1, N, M, Map, TopRightToBottomLeft),
    sets:size(TopLeftToBottomRightSet) - sets:size(TopRightToBottomLeftSet).

add_diagonal(Row, Col, RowInc, ColInc, N, M, Map, Acc) ->
    case maps:is_key({Row, Col}, Map) of
        true ->
            Value = maps:get({Row, Col}, Map),
            NewAcc = sets:add_element(Value, Acc),
            NewRow = Row + RowInc,
            NewCol = Col + ColInc,
            if
                NewRow >= 0 andalso NewRow < N andalso NewCol >= 0 andalso NewCol < M ->
                    add_diagonal(NewRow, NewCol, RowInc, ColInc, N, M, Map, NewAcc);
                true ->
                    NewAcc
            end;
        false ->
            Acc
    end.