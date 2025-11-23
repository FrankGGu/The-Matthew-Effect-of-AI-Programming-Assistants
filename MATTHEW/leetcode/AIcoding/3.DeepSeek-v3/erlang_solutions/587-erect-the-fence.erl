-spec outer_trees(Trees :: [[integer()]]) -> [[integer()]].
outer_trees(Trees) ->
    case length(Trees) =< 1 of
        true -> Trees;
        false ->
            Points = lists:sort(Trees),
            Lower = build_hull(Points),
            Upper = build_hull(lists:reverse(Points)),
            lists:usort(Lower ++ Upper)
    end.

build_hull(Points) ->
    Hull = [],
    lists:foldl(fun(P, Acc) ->
        while(length(Acc) >= 2 andalso cross(lists:nth(length(Acc) - 1, Acc), lists:last(Acc), P) < 0,
            fun() -> lists:sublist(Acc, 1, length(Acc) - 1) end),
        Acc ++ [P]
    end, Hull, Points).

cross(O, A, B) ->
    (A - O) * (B - O).

while(Condition, Body) ->
    case Condition of
        true -> 
            NewBody = Body(),
            while(Condition, NewBody);
        false -> ok
    end.