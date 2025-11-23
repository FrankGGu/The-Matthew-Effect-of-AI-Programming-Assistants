-module(solution).
-export([num_after_reversal/1]).

num_after_reversal(N) ->
    Reverse = fun(N) ->
        list_to_integer(lists:reverse(integer_to_list(N)))
    end,
    Reverse(Reverse(N)).