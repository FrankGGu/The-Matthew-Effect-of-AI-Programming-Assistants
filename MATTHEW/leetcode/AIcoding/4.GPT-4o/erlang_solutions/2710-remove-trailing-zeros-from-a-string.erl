-module(solution).
-export([remove_trailing_zeros/1]).

remove_trailing_zeros(S) ->
    lists:reverse(lists:drop_while(fun(X) -> X =:= $0 end, lists:reverse(S))).