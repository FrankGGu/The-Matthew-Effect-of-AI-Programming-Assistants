-module(max_score).
-export([maximum_score/2]).

maximum_score(Nums, Multipliers) ->
    maximum_score(Nums, Multipliers, 0, 0, length(Nums) - 1, {}).

maximum_score(Nums, Multipliers, MultiplierIndex, Left, Right, Memo) ->
    case maps:is_key({MultiplierIndex, Left}, Memo) of
        true ->
            maps:get({MultiplierIndex, Left}, Memo);
        false ->
            case MultiplierIndex == length(Multipliers) of
                true ->
                    0;
                false ->
                    Multiplier = lists:nth(MultiplierIndex + 1, Multipliers),
                    LeftScore = Multiplier * lists:nth(Left + 1, Nums) +
                                maximum_score(Nums, Multipliers, MultiplierIndex + 1, Left + 1, Right, Memo),
                    RightScore = Multiplier * lists:nth(Right + 1, Nums) +
                                maximum_score(Nums, Multipliers, MultiplierIndex + 1, Left, Right - 1, Memo),
                    MaxScore = max(LeftScore, RightScore),
                    NewMemo = maps:put({MultiplierIndex, Left}, MaxScore, Memo),
                    MaxScore
            end
    end.