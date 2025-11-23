-module(shifting_letters_ii).
-export([shiftingLetters/2]).

shiftingLetters(S, Shifts) ->
    Len = length(S),
    PrefixSum = lists:foldl(
        fun([Start, End, Direction], Acc) ->
            ShiftValue = case Direction of
                1 -> 1;
                0 -> -1
            end,
            Acc1 = lists:update_at(Start + 1, element(Start + 1, Acc) + ShiftValue, Acc),
            lists:update_at(End + 2, element(End + 2, Acc) - ShiftValue, Acc1)
        end,
        lists:seq(0, Len + 1, 0),
        Shifts
    ),

    ShiftAmounts = lists:foldl(
        fun(X, {Sum, Acc}) ->
            NewSum = Sum + X,
            {NewSum, Acc ++ [NewSum]}
        end,
        {0, []},
        lists:sublist(PrefixSum, 2, Len)
    ),

    ShiftedChars = lists:map(
        fun({Char, ShiftAmount}) ->
            Base = $a,
            Shifted = (Char - Base + ShiftAmount) rem 26,
            if Shifted < 0 ->
                Base + Shifted + 26;
            true ->
                Base + Shifted
            end
        end,
        lists:zip(string:to_charlist(S), element(2, ShiftAmounts))
    ),

    list_to_binary(ShiftedChars).