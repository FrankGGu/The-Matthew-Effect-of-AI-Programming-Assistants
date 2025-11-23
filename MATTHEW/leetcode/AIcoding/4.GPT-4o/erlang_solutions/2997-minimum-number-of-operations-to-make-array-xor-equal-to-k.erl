-module(solution).
-export([minimum_operations/3]).

minimum_operations(N, K, A) ->
    Target = K bxor lists:foldl(bxor, 0, A),
    if
        Target == 0 ->
            0;
        Target > N ->
            -1;
        true ->
            1
    end.