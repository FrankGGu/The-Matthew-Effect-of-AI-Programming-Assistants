-spec ship_within_days(Weights :: [integer()], Days :: integer()) -> integer().
ship_within_days(Weights, Days) ->
    Left = lists:max(Weights),
    Right = lists:sum(Weights),
    binary_search(Weights, Days, Left, Right).

binary_search(Weights, Days, Left, Right) when Left < Right ->
    Mid = Left + (Right - Left) div 2,
    case can_ship(Weights, Days, Mid) of
        true -> binary_search(Weights, Days, Left, Mid);
        false -> binary_search(Weights, Days, Mid + 1, Right)
    end;
binary_search(_, _, Left, _) ->
    Left.

can_ship(Weights, Days, Capacity) ->
    can_ship(Weights, Days, Capacity, 0, 1).

can_ship([], _, _, Current, _) ->
    Current =< 0;
can_ship([W | Rest], Days, Capacity, Current, Day) when Current + W =< Capacity ->
    can_ship(Rest, Days, Capacity, Current + W, Day);
can_ship([W | Rest], Days, Capacity, _, Day) when Day < Days ->
    can_ship(Rest, Days, Capacity, W, Day + 1);
can_ship(_, _, _, _, _) ->
    false.