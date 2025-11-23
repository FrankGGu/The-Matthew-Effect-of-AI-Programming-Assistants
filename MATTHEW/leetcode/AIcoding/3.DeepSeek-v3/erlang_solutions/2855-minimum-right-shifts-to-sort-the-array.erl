-spec minimum_right_shifts(Nums :: [integer()]) -> integer().
minimum_right_shifts(Nums) ->
    case is_sorted(Nums) of
        true -> 0;
        false ->
            case find_pivot(Nums) of
                -1 -> -1;
                Pivot -> length(Nums) - Pivot
            end
    end.

is_sorted(List) ->
    is_sorted(List, true).

is_sorted([_], Acc) -> Acc;
is_sorted([A, B | Rest], Acc) ->
    is_sorted([B | Rest], Acc and (A =< B)).

find_pivot(List) ->
    find_pivot(List, 0, length(List) - 1).

find_pivot([_], _, _) -> -1;
find_pivot([A, B | Rest], Index, Len) ->
    if
        A > B -> Index + 1;
        true -> find_pivot([B | Rest], Index + 1, Len)
    end.