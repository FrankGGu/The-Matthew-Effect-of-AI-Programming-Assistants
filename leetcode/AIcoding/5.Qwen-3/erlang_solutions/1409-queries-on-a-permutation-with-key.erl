-module(queries_on_a_permutation_with_key).
-export([process/1]).

process(Queries) ->
    N = length(Queries),
    Result = lists:foldl(fun(Q, Acc) -> [Q + 1 | Acc] end, [], Queries),
    lists:reverse(Result).