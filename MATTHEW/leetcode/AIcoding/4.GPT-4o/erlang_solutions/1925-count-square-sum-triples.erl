-module(solution).
-export([count_triplets/1]).

count_triplets(N) ->
    Count = lists:sum(
        [ if 
            X*X + Y*Y =:= Z*Z -> 1;
            true -> 0
          end || X <- lists:seq(1, N), Y <- lists:seq(X, N), Z <- lists:seq(Y, N)]
    ),
    Count.