-module(ball_fall).
-export([ball_fall/1]).

ball_fall(B) ->
    N = length(B),
    M = length(hd(B)),
    lists:map(fun(I) -> fall(B, I, 0, N, M) end, lists:seq(0, M-1)).

fall(_, _, Row, N, _) when Row >= N ->
    -1;
fall(B, Col, Row, N, M) ->
    Current = lists:nth(Col+1, lists:nth(Row+1, B)),
    NextCol = case Current of
        1 ->
            if Col+1 < M andalso lists:nth(Col+2, lists:nth(Row+1, B)) == 1 ->
                Col+1;
            true ->
                -1
            end;
        -1 ->
            if Col-1 >= 0 andalso lists:nth(Col, lists:nth(Row+1, B)) == -1 ->
                Col-1;
            true ->
                -1
            end
    end,
    if NextCol == -1 -> -1;
       true -> fall(B, NextCol, Row+1, N, M)
    end.