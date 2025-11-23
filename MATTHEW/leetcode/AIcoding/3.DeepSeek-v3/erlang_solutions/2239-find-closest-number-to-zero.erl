-spec find_closest_number(Nums :: [integer()]) -> integer().
find_closest_number(Nums) ->
    lists:foldl(fun(N, {MinDist, Closest}) ->
        Dist = abs(N),
        if
            Dist < MinDist -> {Dist, N};
            Dist == MinDist andalso N > Closest -> {Dist, N};
            true -> {MinDist, Closest}
        end
    end, {abs(hd(Nums)), hd(Nums)}, tl(Nums)),
    element(2, lists:foldl(fun(N, {MinDist, Closest}) ->
        Dist = abs(N),
        if
            Dist < MinDist -> {Dist, N};
            Dist == MinDist andalso N > Closest -> {Dist, N};
            true -> {MinDist, Closest}
        end
    end, {abs(hd(Nums)), hd(Nums)}, tl(Nums))).