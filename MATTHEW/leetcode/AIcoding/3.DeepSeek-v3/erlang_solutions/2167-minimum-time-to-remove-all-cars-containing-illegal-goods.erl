-spec minimum_time(S :: unicode:unicode_binary()) -> integer().
minimum_time(S) ->
    Bin = binary_to_list(S),
    Left = lists:foldl(fun(Ch, Acc) ->
        case Ch of
            $1 -> min(Acc + 2, length(Bin) + 1);
            $0 -> Acc
        end
    end, 0, Bin),
    Right = lists:foldr(fun(Ch, {Count, Min}) ->
        case Ch of
            $1 -> {Count + 1, min(Min, Count + 1)};
            $0 -> {Count, Min}
        end
    end, {0, length(Bin) + 1}, Bin),
    min(Left, element(2, Right)).