-module(solution).
-export([wiggleMaxLength/1]).

wiggleMaxLength(Nums) ->
    Len = length(Nums),
    if
        Len < 2 -> Len;
        true ->
            wiggle_max_length_loop(tl(Nums), hd(Nums), 1, 1)
    end.

wiggle_max_length_loop([], _Prev, Up, Down) ->
    max(Up, Down);
wiggle_max_length_loop([Curr|T], Prev, Up, Down) ->
    if
        Curr > Prev ->
            wiggle_max_length_loop(T, Curr, Down + 1, Down);
        Curr < Prev ->
            wiggle_max_length_loop(T, Curr, Up, Up + 1);
        true ->
            wiggle_max_length_loop(T, Curr, Up, Down)
    end.

max(A, B) ->
    if A > B -> A;
       true -> B
    end.