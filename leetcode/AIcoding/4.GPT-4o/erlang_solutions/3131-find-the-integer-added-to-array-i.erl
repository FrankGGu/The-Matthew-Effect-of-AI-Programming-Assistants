-module(solution).
-export([find_integer/2]).

find_integer(N, A) when is_list(A) ->
    Total = lists:sum(A) + N,
    Length = length(A) + 1,
    Integer = Total div Length,
    Integer.