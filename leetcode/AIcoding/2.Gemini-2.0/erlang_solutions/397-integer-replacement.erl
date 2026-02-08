-module(integer_replacement).
-export([integer_replacement/1]).

integer_replacement(N) ->
    integer_replacement_helper(N, 0).

integer_replacement_helper(1, Count) ->
    Count;
integer_replacement_helper(N, Count) when N rem 2 == 0 ->
    integer_replacement_helper(N div 2, Count + 1);
integer_replacement_helper(N, Count) ->
    integer_replacement_helper(min(N + 1, N - 1), Count + 1).