-module(shifting_letters).
-export([shifting_letters/2]).

shifting_letters(S, Shifts) ->
    N = length(S),
    Diff = lists:duplicate(N + 1, 0),
    UpdatedDiff = process_shifts(Shifts, Diff),
    Prefix = lists:duplicate(N, 0),
    PrefixSum = calculate_prefix_sum(UpdatedDiff, Prefix, 0, 1),
    ShiftedChars = shift_chars(S, PrefixSum, []),
    lists:reverse(ShiftedChars).

process_shifts([], Diff) -> Diff;
process_shifts([[Start, End, Dir] | Rest], Diff) ->
    Delta = case Dir of
                0 -> -1;
                1 -> 1
            end,
    NewDiff1 = update_diff(Start + 1, Delta, Diff),
    NewDiff2 = update_diff(End + 2, -Delta, NewDiff1),
    process_shifts(Rest, NewDiff2).

update_diff(Index, Delta, Diff) ->
    case Index > length(Diff) of
        true -> Diff;
        false ->
            {Before, [Val | After]} = lists:split(Index - 1, Diff),
            lists:append([Before, [Val + Delta], After])
    end.

calculate_prefix_sum([_], Prefix, _, _) -> Prefix;
calculate_prefix_sum([Val | Rest], Prefix, Sum, Index) ->
    NewSum = Sum + Val,
    NewPrefix = case Index > length(Prefix) of
                    true -> Prefix;
                    false ->
                        {Before, [Old | After]} = lists:split(Index - 1, Prefix),
                        lists:append([Before, [Old + NewSum], After])
                end,
    calculate_prefix_sum(Rest, NewPrefix, NewSum, Index + 1).

shift_chars([], _, Acc) -> Acc;
shift_chars([Char | Rest], [Shift | Shifts], Acc) ->
    AdjustedShift = Shift rem 26,
    NewChar = (Char - $a + AdjustedShift + 26) rem 26 + $a,
    shift_chars(Rest, Shifts, [NewChar | Acc]).