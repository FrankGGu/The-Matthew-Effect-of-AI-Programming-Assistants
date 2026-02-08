-spec count_collisions(Directions :: unicode:unicode_binary()) -> integer().
count_collisions(Directions) ->
    S = binary_to_list(Directions),
    N = length(S),
    Left = lists:duplicate(N, $L),
    Right = lists:duplicate(N, $R),
    if
        S =:= Left -> 0;
        S =:= Right -> 0;
        true ->
            Collisions = 0,
            {Collisions1, _} = count_collisions(S, Collisions),
            Collisions1
    end.

count_collisions([], Acc) -> {Acc, []};
count_collisions([H|T], Acc) ->
    case H of
        $L -> count_collisions(T, Acc);
        $R ->
            case T of
                [] -> {Acc, [$R]};
                [Next|Rest] ->
                    case Next of
                        $L -> {Acc + 2, [$S|Rest]};
                        $S -> {Acc + 1, [$S|Rest]};
                        $R -> 
                            {NewAcc, NewRest} = count_collisions(Rest, Acc),
                            {NewAcc, [$R, $R|NewRest]}
                    end
            end;
        $S ->
            {NewAcc, NewRest} = count_collisions(T, Acc),
            {NewAcc, [$S|NewRest]}
    end.