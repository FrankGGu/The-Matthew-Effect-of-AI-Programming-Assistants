-spec minimum_chairs(S :: unicode:unicode_binary()) -> integer().
minimum_chairs(S) ->
    lists:foldl(fun
        ($E, {Current, Max}) -> {Current + 1, max(Current + 1, Max)};
        ($L, {Current, Max}) -> {Current - 1, Max}
    end, {0, 0}, S),
    element(2, lists:foldl(fun
        ($E, {Current, Max}) -> {Current + 1, max(Current + 1, Max)};
        ($L, {Current, Max}) -> {Current - 1, Max}
    end, {0, 0}, S)).