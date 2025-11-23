-module(largest_triangle_area).
-export([largest_triangle_area/1]).

largest_triangle_area(Points) ->
    Len = length(Points),
    lists:foldl(
        fun(I, MaxArea) ->
            lists:foldl(
                fun(J, MaxArea2) ->
                    lists:foldl(
                        fun(K, MaxArea3) ->
                            if I /= J and I /= K and J /= K then
                                P1 = lists:nth(I, Points),
                                P2 = lists:nth(J, Points),
                                P3 = lists:nth(K, Points),
                                Area = 0.5 * abs((P2 !! 0 - P1 !! 0) * (P3 !! 1 - P1 !! 1) - (P3 !! 0 - P1 !! 0) * (P2 !! 1 - P1 !! 1)),
                                max(MaxArea3, Area)
                            else
                                MaxArea3
                            end
                        end,
                        MaxArea2,
                        lists:seq(1, Len)
                    )
                end,
                MaxArea,
                lists:seq(1, Len)
            )
        end,
        0.0,
        lists:seq(1, Len)
    ).