-module(solution).
-export([mark_elements/2]).

mark_elements(Arr, Queries) ->
    Max = lists:max(Arr),
    Marked = lists:foldl(fun(X, Acc) -> lists:foldl(fun(Q, A) -> if Q > X -> A; true -> [X | A] end end, Acc, Queries) end, [], Arr),
    lists:reverse(Marked).