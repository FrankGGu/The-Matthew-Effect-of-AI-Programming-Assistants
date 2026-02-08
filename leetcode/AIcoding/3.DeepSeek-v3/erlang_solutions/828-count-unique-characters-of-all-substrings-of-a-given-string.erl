-spec count_unique_chars(S :: unicode:unicode_binary()) -> integer().
count_unique_chars(S) ->
    List = unicode:characters_to_list(S),
    N = length(List),
    maps:fold(fun(_, V, Acc) -> Acc + V end, 0, 
        lists:foldl(fun(I, Acc) ->
            Char = lists:nth(I, List),
            Left = case find_last_occurrence(Char, I - 1, List) of
                -1 -> I;
                L -> I - L
            end,
            Right = case find_next_occurrence(Char, I + 1, List) of
                -1 -> N - I + 1;
                R -> R - I
            end,
            maps:update_with(Char, fun(Old) -> Old + Left * Right end, Left * Right, Acc)
        end, maps:new(), lists:seq(1, N)))
    ).

find_last_occurrence(Char, End, List) ->
    find_last_occurrence(Char, End, List, -1).

find_last_occurrence(_, 0, _, Last) -> Last;
find_last_occurrence(Char, Pos, List, Last) ->
    case lists:nth(Pos, List) of
        Char -> Pos;
        _ -> find_last_occurrence(Char, Pos - 1, List, Last)
    end.

find_next_occurrence(Char, Start, List) ->
    find_next_occurrence(Char, Start, List, length(List)).

find_next_occurrence(_, Start, _, Len) when Start > Len -> -1;
find_next_occurrence(Char, Pos, List, _) ->
    case lists:nth(Pos, List) of
        Char -> Pos;
        _ -> find_next_occurrence(Char, Pos + 1, List, Len)
    end.