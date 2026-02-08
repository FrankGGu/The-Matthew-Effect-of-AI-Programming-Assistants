-module(solution).
-export([count_special_characters/1]).

-spec count_special_characters(S :: unicode:unicode_binary() | unicode:unicode_list()) -> integer().
count_special_characters(S) ->
    {LowerMask, UpperMask} = lists:foldl(
        fun(Char, {LM, UM}) ->
            case Char of
                C when C >= $a, C <= $z ->
                    {LM bor (1 bsl (C - $a)), UM};
                C when C >= $A, C <= $Z ->
                    {LM, UM bor (1 bsl (C - $A))};
                _ ->
                    {LM, UM}
            end
        end,
        {0, 0},
        S
    ),

    count_special_chars_from_masks(0, 0, LowerMask, UpperMask).

count_special_chars_from_masks(Idx, Count, LowerMask, UpperMask) when Idx < 26 ->
    Bit = 1 bsl Idx,
    NewCount = if
        (LowerMask band Bit) /= 0 andalso (UpperMask band Bit) /= 0 ->
            Count + 1;
        true ->
            Count
    end,
    count_special_chars_from_masks(Idx + 1, NewCount, LowerMask, UpperMask);
count_special_chars_from_masks(_Idx, Count, _LowerMask, _UpperMask) ->
    Count.