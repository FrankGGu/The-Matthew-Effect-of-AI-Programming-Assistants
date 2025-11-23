-spec count_points(Rings :: unicode:unicode_binary()) -> integer().
count_points(Rings) ->
    Rods = maps:new(),
    count_points(Rings, 0, Rods).

count_points(<<>>, Index, Rods) ->
    maps:fold(fun(_, Colors, Acc) ->
        case maps:size(Colors) of
            3 -> Acc + 1;
            _ -> Acc
        end
    end, 0, Rods);
count_points(<<Color:8, Rod:8, Rest/binary>>, Index, Rods) ->
    NewRods = case maps:find(Rod, Rods) of
        {ok, Colors} -> maps:put(Rod, maps:put(Color, true, Colors), Rods);
        error -> maps:put(Rod, maps:from_list([{Color, true}]), Rods)
    end,
    count_points(Rest, Index + 2, NewRods).