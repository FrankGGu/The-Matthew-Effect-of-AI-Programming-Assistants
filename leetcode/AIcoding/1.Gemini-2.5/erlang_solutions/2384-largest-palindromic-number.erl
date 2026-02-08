-module(largest_palindromic_number).
-export([largest_palindromic_number/1]).

-spec largest_palindromic_number(Num :: unicode:unicode_binary()) -> unicode:unicode_binary().
largest_palindromic_number(Num) ->
    CharList = unicode:characters_to_list(Num),

    Counts = lists:foldl(fun(C, Acc) -> maps:update_with(C, fun(V) -> V + 1 end, 1, Acc) end, #{}, CharList),

    {FinalLeftHalfChars, FinalRemainingCounts} = lists:foldl(
        fun(DigitChar, {AccLeftHalf, AccRemainingCounts}) ->
            Count = maps:get(DigitChar, AccRemainingCounts, 0),
            NumPairs = Count div 2,
            NewAccLeftHalf = lists:duplicate(NumPairs, DigitChar) ++ AccLeftHalf,
            NewAccRemainingCounts = maps:update(DigitChar, Count rem 2, AccRemainingCounts),
            {NewAccLeftHalf, NewAccRemainingCounts}
        end,
        {[], Counts},
        lists:reverse(lists:seq($0, $9))
    ),

    MiddleDigitChar = lists:foldl(
        fun(DigitChar, AccMiddle) ->
            case AccMiddle of
                undefined ->
                    Count = maps:get(DigitChar, FinalRemainingCounts, 0),
                    case Count of
                        1 -> DigitChar;
                        _ -> undefined
                    end;
                _ -> AccMiddle
            end
        end,
        undefined,
        lists:reverse(lists:seq($0, $9))
    ),

    RightHalfChars = lists:reverse(FinalLeftHalfChars),

    PalindromeChars = case MiddleDigitChar of
        undefined ->
            FinalLeftHalfChars ++ RightHalfChars;
        _ ->
            FinalLeftHalfChars ++ [MiddleDigitChar] ++ RightHalfChars
    end,

    case PalindromeChars of
        [$0 | _] when length(PalindromeChars) > 1 ->
            <<"0">>;
        _ ->
            unicode:characters_to_binary(PalindromeChars)
    end.