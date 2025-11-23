-module(triangle).
-export([triangle/3]).

triangle(A, B, C) ->
    case {A, B, C} of
        {A, B, C} when A =< 0; B =< 0; C =< 0 -> "Not a Triangle";
        {A, B, C} when A + B =< C; B + C =< A; A + C =< B -> "Not a Triangle";
        {A, B, C} when A == B andalso B == C -> "Equilateral";
        {A, B, C} when A == B; B == C; A == C -> "Isosceles";
        _ -> "Scalene"
    end.