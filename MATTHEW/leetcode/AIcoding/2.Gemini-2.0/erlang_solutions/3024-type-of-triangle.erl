-module(solution).
-export([triangle_type/3]).

triangle_type(A, B, C) ->
  Sides = lists:sort([A, B, C]),
  [S1, S2, S3] = Sides,
  if
    S1 + S2 =< S3 -> "Not A Triangle";
    S1 == S2 and S2 == S3 -> "Equilateral";
    S1 == S2 or S2 == S3 -> "Isosceles";
    true -> "Scalene"
  end.