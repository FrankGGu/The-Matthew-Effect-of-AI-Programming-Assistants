-module(solution).
-export([num_ways/1]).

num_ways(S) ->
    N = length(S),
    Count = fun(X, Y) -> 
        if 
            X == 0 -> Y;
            Y == 0 -> X;
            true -> 0
        end
    end,
    lists:sum(lists:map(fun(X) -> 
        case is_possible(S, X) of 
            true -> 1; 
            false -> 0 
        end 
    end, lists:seq(1, N div 2))).

is_possible(S, X) ->
    N = length(S),
    Prefix = lists:sublist(S, X),
    Number = list_to_integer(lists:flatten(Prefix)),
    Next = Number + 1,
    NextStr = integer_to_list(Next),
    Rest = lists:sublist(S, X, N - X),
    lists:prefix(Rest, NextStr) orelse
    (N > X + length(NextStr) andalso 
    is_possible(lists:sublist(S, X + length(NextStr)), X + length(NextStr))).