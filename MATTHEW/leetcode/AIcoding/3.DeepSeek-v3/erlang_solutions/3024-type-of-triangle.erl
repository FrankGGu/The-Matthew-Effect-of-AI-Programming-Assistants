-spec triangle_type(Sides :: [integer()]) -> unicode:unicode_binary().
triangle_type([A, B, C]) ->
    Sorted = lists:sort([A, B, C]),
    case Sorted of
        [X, Y, Z] when X + Y =< Z -> <<"none">>;
        [X, Y, Z] when X =:= Y, Y =:= Z -> <<"equilateral">>;
        [X, Y, Z] when X =:= Y; Y =:= Z; X =:= Z -> <<"isosceles">>;
        _ -> <<"scalene">>
    end.