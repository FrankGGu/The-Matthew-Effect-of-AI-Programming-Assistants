-module(solution).
-export([count_right_triangles/1]).

count_right_triangles(N) ->
    count_right_triangles(N, 1, 1, 0).

count_right_triangles(N, A, B, Count) when A > N -> 
    Count;
count_right_triangles(N, A, B, Count) when B > N -> 
    count_right_triangles(N, A + 1, 1, Count);
count_right_triangles(N, A, B, Count) ->
    C2 = A * A + B * B,
    C = round(math:sqrt(C2)),
    if
        C * C =:= C2, C =< N -> 
            count_right_triangles(N, A, B + 1, Count + 1);
        true -> 
            count_right_triangles(N, A, B + 1, Count)
    end.