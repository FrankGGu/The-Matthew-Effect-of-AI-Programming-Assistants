-module(solution).
-export([reverse_degree/1]).

reverse_degree(String) ->
    lists:reverse(string:to_list(String)).