-module(right_triangles).
-export([num_of_right_triangles/1]).

num_of_right_triangles(Points) ->
    PointsSorted = lists:sort(Points),
    Length = length(PointsSorted),
    Count = 0,
    do_count(PointsSorted, 0, Length, Count).

do_count(_, _, N, Count) when N == 0 -> Count;
do_count(Points, I, N, Count) ->
    {X1, Y1} = lists:nth(I + 1, Points),
    do_count_2(Points, I, I + 1, N, X1, Y1, Count).

do_count_2(_, _, J, N, _, _, Count) when J >= N -> Count;
do_count_2(Points, I, J, N, X1, Y1, Count) ->
    {X2, Y2} = lists:nth(J + 1, Points),
    Dx = X2 - X1,
    Dy = Y2 - Y1,
    do_count_3(Points, I, J, N, X1, Y1, X2, Y2, Dx, Dy, Count).

do_count_3(_, _, _, _, _, _, _, _, _, _, Count) when Count >= 1000000000 -> Count;
do_count_3(Points, I, J, N, X1, Y1, X2, Y2, Dx, Dy, Count) ->
    do_count_4(Points, I, J, N, X1, Y1, X2, Y2, Dx, Dy, Count, 0).

do_count_4(_, _, _, _, _, _, _, _, _, _, Count, K) when K >= N -> Count;
do_count_4(Points, I, J, N, X1, Y1, X2, Y2, Dx, Dy, Count, K) ->
    if
        K == I -> do_count_4(Points, I, J, N, X1, Y1, X2, Y2, Dx, Dy, Count, K + 1);
        K == J -> do_count_4(Points, I, J, N, X1, Y1, X2, Y2, Dx, Dy, Count, K + 1);
        true ->
            {X3, Y3} = lists:nth(K + 1, Points),
            Dx1 = X3 - X1,
            Dy1 = Y3 - Y1,
            Dx2 = X3 - X2,
            Dy2 = Y3 - Y2,
            Dot1 = Dx * Dx1 + Dy * Dy1,
            Dot2 = Dx2 * Dx + Dy2 * Dy,
            if
                Dot1 == 0 orelse Dot2 == 0 ->
                    do_count_4(Points, I, J, N, X1, Y1, X2, Y2, Dx, Dy, Count + 1, K + 1);
                true ->
                    do_count_4(Points, I, J, N, X1, Y1, X2, Y2, Dx, Dy, Count, K + 1)
            end
    end.

do_count_2(Points, I, J, N, X1, Y1, Count) ->
    do_count_2(Points, I, J + 1, N, X1, Y1, Count).