-spec minimized_maximum(N :: integer(), Quantities :: [integer()]) -> integer().
minimized_maximum(N, Quantities) ->
    Left = 1,
    Right = lists:max(Quantities),
    binary_search(Left, Right, Quantities, N).

binary_search(Left, Right, Quantities, N) when Left < Right ->
    Mid = (Left + Right) div 2,
    case can_distribute(Quantities, Mid, N) of
        true ->
            binary_search(Left, Mid, Quantities, N);
        false ->
            binary_search(Mid + 1, Right, Quantities, N)
    end;
binary_search(Left, _, _, _) ->
    Left.

can_distribute(Quantities, MaxPerStore, N) ->
    Total = lists:foldl(fun(Q, Acc) -> Acc + ((Q + MaxPerStore - 1) div MaxPerStore) end, 0, Quantities),
    Total =< N.