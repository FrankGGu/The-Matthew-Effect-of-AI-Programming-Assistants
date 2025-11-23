-spec find_restaurant(Andre :: [unicode:unicode_binary()], Elisa :: [unicode:unicode_binary()]) -> [unicode:unicode_binary()].
find_restaurant(Andre, Elisa) ->
    Map = maps:from_list([{R, I} || {R, I} <- lists:zip(Andre, lists:seq(0, length(Andre) - 1))]),
    {MinSum, Res} = lists:foldl(fun(R, {CurrentMin, CurrentRes}) ->
        case maps:get(R, Map, none) of
            none -> {CurrentMin, CurrentRes};
            I ->
                Sum = I + ElisaIndex,
                if
                    Sum < CurrentMin -> {Sum, [R]};
                    Sum == CurrentMin -> {CurrentMin, [R | CurrentRes]};
                    true -> {CurrentMin, CurrentRes}
                end
        end
    end, {999999, []}, lists:zip(Elisa, lists:seq(0, length(Elisa) - 1))),
    lists:reverse(Res).