-module(solution).
-export([max_sum_of_nodes/1]).

-type node() :: {integer(), [node()]}.

-max_sum_of_nodes(Node) ->
    max_sum(Node, 0).

max_sum({Val, Children}, ParentVal) ->
    case Val of
        Val when Val < ParentVal ->
            Sum = lists:sum([max_sum(Child, Val) || Child <- Children]),
            Val + Sum;
        _ ->
            Sum = lists:sum([max_sum(Child, Val) || Child <- Children]),
            Val + Sum
    end.