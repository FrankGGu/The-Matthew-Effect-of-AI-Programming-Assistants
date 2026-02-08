-spec triangleType(A :: integer(), B :: integer(), C :: integer()) -> unicode:chardata().
triangleType(A, B, C) when A =< 0; B =< 0; C =< 0 ->
    "None";
triangleType(A, B, C) when A + B =< C; A + C =< B; B + C =< A ->
    "None";
triangleType(A, B, C) when A == B, B == C ->
    "Equilateral";
triangleType(A, B, C) when A == B; B == C; A == C ->
    "Isosceles";
triangleType(_, _, _) ->
    "Scalene".