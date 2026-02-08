-spec minimum_perimeter(needed_apples :: integer()) -> integer().
minimum_perimeter(NeededApples) ->
    binary_search(NeededApples, 1, 1 bsl 20).

binary_search(NeededApples, Left, Right) ->
    Mid = (Left + Right) div 2,
    Total = 2 * Mid * (Mid + 1) * (2 * Mid + 1),
    if
        Total >= NeededApples ->
            case Mid == Left of
                true -> 8 * Mid;
                false -> binary_search(NeededApples, Left, Mid)
            end;
        true ->
            binary_search(NeededApples, Mid + 1, Right)
    end.