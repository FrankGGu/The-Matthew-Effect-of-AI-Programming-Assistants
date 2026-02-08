-module(solution).
-export([twoFurthestHouses/1]).

twoFurthestHouses(Colors) ->
    N = length(Colors),
    Array = array:from_list(Colors),

    Color0 = array:get(0, Array),
    ColorN_1 = array:get(N-1, Array),

    MaxDistFrom0 = find_dist_from_first(Array, Color0, N-1),

    MaxDistFromN_1 = find_dist_from_last(Array, N, ColorN_1, 0),

    max(MaxDistFrom0, MaxDistFromN_1).

find_dist_from_first(Array, Color0, J) ->
    ColorJ = array:get(J, Array),
    if
        ColorJ =/= Color0 -> J;
        true -> find_dist_from_first(Array, Color0, J-1)
    end.

find_dist_from_last(Array, N, ColorN_1, J) ->
    ColorJ = array:get(J, Array),
    if
        ColorJ =/= ColorN_1 -> (N-1) - J;
        true -> find_dist_from_last(Array, N, ColorN_1, J+1)
    end.