-spec give_gem(Gems :: [integer()], Operations :: [[integer()]]) -> integer().
give_gem(Gems, Operations) ->
    lists:foldl(fun([X, Y], Acc) ->
        Give = Acc[X] div 2,
        Acc1 = Acc#{X := Acc[X] - Give},
        Acc1#{Y := Acc1[Y] + Give}
    end, maps:from_list(lists:zip(lists:seq(0, length(Gems) - 1), Gems)), Operations),
    GemsMap = lists:foldl(fun([X, Y], Acc) ->
        Give = maps:get(X, Acc) div 2,
        Acc1 = Acc#{X := maps:get(X, Acc) - Give},
        Acc1#{Y := maps:get(Y, Acc1) + Give}
    end, maps:from_list(lists:zip(lists:seq(0, length(Gems) - 1), Gems)), Operations),
    {Min, Max} = maps:fold(fun(_, V, {CurMin, CurMax}) -> {min(V, CurMin), max(V, CurMax)} end, {999999, 0}, GemsMap),
    Max - Min.