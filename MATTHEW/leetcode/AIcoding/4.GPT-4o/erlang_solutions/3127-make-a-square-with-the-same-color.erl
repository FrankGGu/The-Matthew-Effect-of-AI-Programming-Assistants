-module(solution).
-export([makesquare/1]).

makesquare(Sides) when length(Sides) == 4 ->
    SortedSides = lists:sort(Sides),
    make_square(SortedSides, 0, 0, 0, 0, 0);
makesquare(_) ->
    false.

make_square([A, B, C, D], Side1, Side2, Side3, Side4, Sum) when Sum =:= 4 * A ->
    true;
make_square([A, B, C, D], Side1, Side2, Side3, Side4, Sum) ->
    lists:any(fun(X) -> 
        case X of
            A -> make_square([A, B, C, D], Side1 + A, Side2, Side3, Side4, Sum + A);
            B -> make_square([A, B, C, D], Side1, Side2 + B, Side3, Side4, Sum + B);
            C -> make_square([A, B, C, D], Side1, Side2, Side3 + C, Side4, Sum + C);
            D -> make_square([A, B, C, D], Side1, Side2, Side3, Side4 + D, Sum + D)
        end
    end, [A, B, C, D]);
make_square(_, _, _, _, _, _) ->
    false.