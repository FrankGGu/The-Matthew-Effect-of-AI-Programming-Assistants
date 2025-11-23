-spec color_combo(colors :: [integer()]) -> [[integer()]].
color_combo(Colors) ->
    Sorted = lists:sort(Colors),
    find_combos(Sorted, []).

find_combos([], _) -> [];
find_combos([H|T], Prev) ->
    case lists:member(H, Prev) of
        true -> find_combos(T, Prev);
        false -> 
            case find_complement(T, H) of
                [] -> find_combos(T, [H|Prev]);
                [C|_] -> [[H, C] | find_combos(T, [H|Prev])]
            end
    end.

find_complement([], _) -> [];
find_complement([H|T], Target) ->
    case H =:= Target of
        true -> [H | find_complement(T, Target)];
        false -> find_complement(T, Target)
    end.