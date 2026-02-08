-spec min_swaps(S :: unicode:unicode_binary()) -> integer().
min_swaps(S) ->
    min_swaps(binary_to_list(S), 0, 0).

min_swaps([], Open, _) -> (Open + 1) div 2;
min_swaps([Char | Rest], Open, Swaps) ->
    case Char of
        $[ -> min_swaps(Rest, Open + 1, Swaps);
        $] when Open > 0 -> min_swaps(Rest, Open - 1, Swaps);
        $] -> min_swaps(Rest, Open + 1, Swaps + 1)
    end.