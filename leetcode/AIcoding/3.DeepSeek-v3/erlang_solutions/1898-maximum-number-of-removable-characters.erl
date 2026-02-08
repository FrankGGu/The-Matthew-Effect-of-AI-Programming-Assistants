-module(solution).
-export([maximum_removals/3]).

maximum_removals(S, P, Removable) ->
    N = length(Removable),
    Low = 0,
    High = N,
    binary_search(S, P, Removable, Low, High).

binary_search(S, P, Removable, Low, High) when Low < High ->
    Mid = (Low + High + 1) div 2,
    case is_subsequence(S, P, Removable, Mid) of
        true -> binary_search(S, P, Removable, Mid, High);
        false -> binary_search(S, P, Removable, Low, Mid - 1)
    end;
binary_search(_, _, _, Low, _) ->
    Low.

is_subsequence(S, P, Removable, K) ->
    Removed = sets:from_list(lists:sublist(Removable, K)),
    S1 = filter_removed(S, Removed, 0),
    check_subsequence(S1, P).

filter_removed([], _, _) -> [];
filter_removed([H|T], Removed, I) ->
    case sets:is_element(I, Removed) of
        true -> filter_removed(T, Removed, I + 1);
        false -> [H | filter_removed(T, Removed, I + 1)]
    end.

check_subsequence(_, []) -> true;
check_subsequence([], _) -> false;
check_subsequence([H|T1], [H|T2]) -> check_subsequence(T1, T2);
check_subsequence([_|T1], T2) -> check_subsequence(T1, T2).