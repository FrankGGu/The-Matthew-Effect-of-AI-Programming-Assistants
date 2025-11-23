-module(solution).
-export([minimum_buckets/1]).

minimum_buckets(S) ->
    SList = binary_to_list(S),
    length([X || X <- SList, X == $H]) + length([X || X <- SList, X == $B]).