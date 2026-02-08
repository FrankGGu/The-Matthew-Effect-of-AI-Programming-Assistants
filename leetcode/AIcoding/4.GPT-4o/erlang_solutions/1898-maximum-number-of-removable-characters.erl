-module(solution).
-export([maximum_removals/3]).

maximum_removals(S, P, A) ->
    max_removable(S, P, A, 0, length(A)).

max_removable(_, _, _, Low, High) when Low > High ->
    Low - 1;
max_removable(S, P, A, Low, High) ->
    Mid = (Low + High) div 2,
    if
        can_remove(S, P, A, Mid) ->
            max_removable(S, P, A, Mid + 1, High);
        true ->
            max_removable(S, P, A, Low, Mid - 1)
    end.

can_remove(S, P, A, K) ->
    Removed = lists:sublist(A, K),
    New_S = remove_chars(S, Removed),
    New_S == P.

remove_chars(S, Removed) ->
    lists:foldl(fun(Char, Acc) -> lists:delete(Char, Acc) end, S, Removed).