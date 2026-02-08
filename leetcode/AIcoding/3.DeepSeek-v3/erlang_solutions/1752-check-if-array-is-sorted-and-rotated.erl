-spec check(List :: [integer()]) -> boolean().
check(List) ->
    N = length(List),
    K = find_k(List, 0, 0),
    if
        K == 0 -> true;
        true -> 
            Rotated = lists:sublist(List, K + 1, N - K) ++ lists:sublist(List, 1, K),
            is_sorted(Rotated)
    end.

find_k([], _, K) -> K;
find_k([A, B | Rest], Index, K) when A > B ->
    find_k([], Index + 1, Index + 1);
find_k([_ | Rest], Index, K) ->
    find_k(Rest, Index + 1, K).

is_sorted([]) -> true;
is_sorted([_]) -> true;
is_sorted([A, B | Rest]) when A =< B ->
    is_sorted([B | Rest]);
is_sorted(_) -> false.