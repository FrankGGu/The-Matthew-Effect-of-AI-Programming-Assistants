-module(delivering_boxes).
-export([maxTotalReward/1]).

maxTotalReward(Boxes) ->
    max_total_reward(Boxes, 0, 0, 0).

max_total_reward([], _, _, Acc) ->
    Acc;
max_total_reward([H | T], Index, Count, Acc) ->
    if
        H == 0 ->
            max_total_reward(T, Index + 1, 0, Acc);
        true ->
            case Count of
                0 ->
                    max_total_reward(T, Index + 1, 1, Acc + H);
                _ ->
                    max_total_reward(T, Index + 1, Count + 1, Acc + H)
            end
    end.