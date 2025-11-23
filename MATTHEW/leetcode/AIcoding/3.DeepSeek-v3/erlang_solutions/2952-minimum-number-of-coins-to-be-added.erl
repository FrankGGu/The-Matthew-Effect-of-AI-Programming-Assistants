-spec minimum_added_coins(Coins :: [integer()], Target :: integer()) -> integer().
minimum_added_coins(Coins, Target) ->
    Sorted = lists:sort(Coins),
    solve(Sorted, Target, 0, 1, 0).

solve(_, Target, Added, Current, _) when Current > Target ->
    Added;
solve(Coins, Target, Added, Current, Index) when Index < length(Coins) ->
    [Coin | Rest] = lists:nthtail(Index, Coins),
    if 
        Coin =< Current ->
            solve(Coins, Target, Added, Current + Coin, Index + 1);
        true ->
            solve(Coins, Target, Added + 1, Current * 2, Index)
    end;
solve(_, Target, Added, Current, _) ->
    if 
        Current =< Target ->
            solve([], Target, Added + 1, Current * 2, 0);
        true ->
            Added
    end.