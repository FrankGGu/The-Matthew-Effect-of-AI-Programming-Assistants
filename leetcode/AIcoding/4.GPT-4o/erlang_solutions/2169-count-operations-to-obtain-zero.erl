-module(solution).
-export([count_operations/2]).

count_operations(A, B) when A == 0; B == 0 -> 0;
count_operations(A, B) -> 
    count_operations(A, B, 0).

count_operations(A, B, Count) when A == 0; B == 0 -> Count;
count_operations(A, B, Count) ->
    case A >= B of
        true -> count_operations(A - B, B, Count + 1);
        false -> count_operations(A, B - A, Count + 1)
    end.