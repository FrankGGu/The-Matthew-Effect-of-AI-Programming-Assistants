-spec min_operations(Boxes :: unicode:unicode_binary()) -> [integer()].
min_operations(Boxes) ->
    B = binary_to_list(Boxes),
    N = length(B),
    Left = lists:foldl(fun(Char, {Count, Sum, Acc}) ->
        case Char of
            $1 -> {Count + 1, Sum + Count, [Sum + Count | Acc]};
            $0 -> {Count, Sum + Count, [Sum + Count | Acc]}
        end
    end, {0, 0, []}, B),
    {_, _, LeftAcc} = Left,
    Right = lists:foldr(fun(Char, {Count, Sum, Acc}) ->
        case Char of
            $1 -> {Count + 1, Sum + Count, [Sum + Count | Acc]};
            $0 -> {Count, Sum + Count, [Sum + Count | Acc]}
        end
    end, {0, 0, []}, B),
    {_, _, RightAcc} = Right,
    lists:zipwith(fun(X, Y) -> X + Y end, lists:reverse(LeftAcc), RightAcc).