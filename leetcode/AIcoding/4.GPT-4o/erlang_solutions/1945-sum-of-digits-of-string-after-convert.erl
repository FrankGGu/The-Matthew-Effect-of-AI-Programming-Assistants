-module(solution).
-export([get_sum|get_sum/1]).

get_sum(S) ->
    Sum = lists:sum(lists:map(fun(C) -> (C - $0) rem 10 end, string:to_list(S))),
    if
        Sum rem 2 =:= 0 -> Sum div 2;
        true -> Sum
    end.

get_sum(S) ->
    get_sum(S).