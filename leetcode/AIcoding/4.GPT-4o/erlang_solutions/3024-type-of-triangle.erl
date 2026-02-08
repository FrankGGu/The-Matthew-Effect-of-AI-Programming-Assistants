-module(solution).
-export([triangle_type/3]).

triangle_type(A, B, C) ->
    case {A, B, C} of
        {X, Y, Z} when X + Y > Z, X + Z > Y, Y + Z > X ->
            case {X, Y, Z} of
                {X, X, X} -> "Equilateral";
                {X, Y, Z} when X == Y; Y == Z; X == Z -> "Isosceles";
                _ -> "Scalene"
            end;
        _ -> "Not a triangle"
    end.