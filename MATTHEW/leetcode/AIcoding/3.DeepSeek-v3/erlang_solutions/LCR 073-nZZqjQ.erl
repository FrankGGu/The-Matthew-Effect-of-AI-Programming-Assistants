-spec min_eating_speed(Piles :: [integer()], H :: integer()) -> integer().
min_eating_speed(Piles, H) ->
    Left = 1,
    Right = lists:max(Piles),
    binary_search(Piles, H, Left, Right).

binary_search(Piles, H, Left, Right) when Left < Right ->
    Mid = Left + (Right - Left) div 2,
    case can_eat_all(Piles, H, Mid) of
        true -> binary_search(Piles, H, Left, Mid);
        false -> binary_search(Piles, H, Mid + 1, Right)
    end;
binary_search(_Piles, _H, Left, _Right) ->
    Left.

can_eat_all(Piles, H, K) ->
    Hours = lists:sum([(P + K - 1) div K || P <- Piles]),
    Hours =< H.