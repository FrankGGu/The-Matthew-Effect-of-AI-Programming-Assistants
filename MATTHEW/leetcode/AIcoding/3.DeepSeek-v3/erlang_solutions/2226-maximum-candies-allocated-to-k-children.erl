-spec maximum_candies(Candies :: [integer()], K :: integer()) -> integer().
maximum_candies(Candies, K) ->
    Left = 1,
    Right = lists:max(Candies),
    binary_search(Candies, K, Left, Right).

binary_search(Candies, K, Left, Right) when Left =< Right ->
    Mid = Left + (Right - Left) div 2,
    case can_allocate(Candies, K, Mid) of
        true ->
            binary_search(Candies, K, Mid + 1, Right);
        false ->
            binary_search(Candies, K, Left, Mid - 1)
    end;
binary_search(_, _, Left, _) ->
    Left - 1.

can_allocate(Candies, K, Mid) ->
    Total = lists:foldl(fun(C, Sum) -> Sum + C div Mid end, 0, Candies),
    Total >= K.