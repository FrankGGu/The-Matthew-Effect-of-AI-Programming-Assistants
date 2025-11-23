-module(minimum_area_rectangle_ii).
-export([minimum_area_rectangle_ii/1]).

minimum_area_rectangle_ii(Points) ->
    N = length(Points),
    MinArea = lists:foldl(
        fun(I, Acc) ->
            lists:foldl(
                fun(J, Acc2) ->
                    if I >= J then
                        Acc2
                    else
                        lists:foldl(
                            fun(K, Acc3) ->
                                if K == I or K == J then
                                    Acc3
                                else
                                    lists:foldl(
                                        fun(L, Acc4) ->
                                            if L == I or L == J or L == K then
                                                Acc4
                                            else
                                                P1 = lists:nth(I+1, Points),
                                                P2 = lists:nth(J+1, Points),
                                                P3 = lists:nth(K+1, Points),
                                                P4 = lists:nth(L+1, Points),

                                                if is_rectangle(P1, P2, P3, P4) then
                                                    Area = rectangle_area(P1, P2, P3, P4),
                                                    min(Acc4, Area)
                                                else
                                                    Acc4
                                                end
                                            end
                                        end,
                                        Acc3,
                                        lists:seq(0, N-1)
                                    )
                                end
                            end,
                            Acc2,
                            lists:seq(0, N-1)
                        )
                    end
                end,
                Acc,
                lists:seq(0, N-1)
            )
        end,
        infinity,
        lists:seq(0, N-1)
    ),
    if MinArea == infinity then
        0.0
    else
        MinArea
    end.

is_rectangle({X1, Y1}, {X2, Y2}, {X3, Y3}, {X4, Y4}) ->
    V1 = {X2 - X1, Y2 - Y1},
    V2 = {X3 - X1, Y3 - Y1},
    V3 = {X4 - X2, Y4 - Y2},
    V4 = {X4 - X3, Y4 - Y3},

    Dot1 = dot_product(V1, V2),
    Dot2 = dot_product(V3, V4),

    V5 = {X4 - X1, Y4 - Y1},
    V6 = {X3 - X2, Y3 - Y2},

    Dot3 = dot_product(V5,V6),

    lists:member(0, [Dot1, Dot2]) andalso
    are_parallel({X2-X1, Y2-Y1}, {X4-X3, Y4-Y3}) andalso
    are_parallel({X3-X1, Y3-Y1}, {X4-X2, Y4-Y2}).

are_parallel({X1, Y1}, {X2, Y2}) ->
    abs(X1*Y2 - X2*Y1) < 1e-6.

dot_product({X1, Y1}, {X2, Y2}) ->
    X1 * X2 + Y1 * Y2.

rectangle_area({X1, Y1}, {X2, Y2}, {X3, Y3}, {X4, Y4}) ->
    D1 = distance({X1, Y1}, {X2, Y2}),
    D2 = distance({X1, Y1}, {X3, Y3}),
    D1 * D2.

distance({X1, Y1}, {X2, Y2}) ->
    math:sqrt((X2 - X1) * (X2 - X1) + (Y2 - Y1) * (Y2 - Y1)).