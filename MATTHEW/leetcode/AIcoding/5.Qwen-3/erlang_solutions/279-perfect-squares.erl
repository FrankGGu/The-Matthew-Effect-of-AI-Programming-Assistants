-module(solution).
-export([num_squares/1]).

num_squares(N) ->
    num_squares(N, erlang:integer_to_list(N)).

num_squares(N, _) when N =< 0 ->
    0;
num_squares(N, S) ->
    Min = lists:min([num_squares(N - list_to_integer([C]), S) + 1 || C <- S, N >= list_to_integer([C])]),
    Min.