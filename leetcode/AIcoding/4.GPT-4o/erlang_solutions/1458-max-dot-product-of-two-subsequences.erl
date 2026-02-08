-module(solution).
-export([max_dot_product/2]).

max_dot_product(A, B) ->
    max_dot_product(A, B, 0, length(A), length(B)).

max_dot_product(_, [], Max, _, _) -> Max;
max_dot_product([], _, Max, _, _) -> Max;
max_dot_product([A | As], [B | Bs], Max, LenA, LenB) ->
    Max1 = max_dot_product(As, Bs, Max + A * B, LenA - 1, LenB - 1),
    Max2 = max_dot_product(As, [B | Bs], Max, LenA - 1, LenB),
    Max3 = max_dot_product([A | As], Bs, Max, LenA, LenB - 1),
    max(Max1, max(Max2, Max3)).