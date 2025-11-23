-spec find_min_arrow_shots(Points :: [[integer()]]) -> integer().
find_min_arrow_shots(Points) ->
    case Points of
        [] -> 0;
        _ ->
            Sorted = lists:sort(fun([A, _], [B, _]) -> A =< B end, Points),
            {_, Arrows} = lists:foldl(fun([Start, End], {PrevEnd, Count}) ->
                case Start > PrevEnd of
                    true -> {End, Count + 1};
                    false -> {min(End, PrevEnd), Count}
                end
            end, {lists:nth(2, hd(Sorted)), 1}, tl(Sorted)),
            Arrows
    end.