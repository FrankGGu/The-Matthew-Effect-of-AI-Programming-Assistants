-module(solution).
-export([maximum_score/3]).

maximum_score(Numbers, Multipliers, Result) ->
    MaxIndex = length(Multipliers),
    DynamicProgramming = lists:duplicate(MaxIndex + 1, lists:duplicate(MaxIndex + 1, -1)),
    max_score(Numbers, Multipliers, 0, 0, MaxIndex, DynamicProgramming).

max_score(_, [], _, _, _, DP) -> 0;
max_score(Numbers, Multipliers, Left, Right, MaxIndex, DP) ->
    if
        Left > MaxIndex -> 0;
        Right > MaxIndex -> 0;
        true ->
            case lists:nth(Left + 1, lists:nth(Right + 1, DP)) of
                -1 ->
                    PickLeft = lists:nth(Left + 1, Multipliers) * lists:nth(length(Numbers) - Right, Numbers) +
                               max_score(Numbers, Multipliers, Left + 1, Right, MaxIndex, DP),
                    PickRight = lists:nth(Right + 1, Multipliers) * lists:nth(length(Numbers) - Left - 1, Numbers) +
                                max_score(Numbers, Multipliers, Left, Right + 1, MaxIndex, DP),
                    MaxValue = max(PickLeft, PickRight),
                    DP1 = lists:replace_element(Left + 1, lists:replace_element(Right + 1, MaxValue, lists:nth(Right + 1, DP)), DP),
                    MaxValue;
                Value -> Value
            end
    end.

max(A, B) -> if A > B -> A; true -> B end.