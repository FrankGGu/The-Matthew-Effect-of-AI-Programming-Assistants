-module(minimum_cost_cooking_time).
-export([min_cost_set_time/3]).

min_cost_set_time(StartAt, MoveCost, PushCost, TargetSeconds) ->
    min(
        min_cost(StartAt, MoveCost, PushCost, TargetSeconds div 60, TargetSeconds rem 60),
        min_cost(StartAt, MoveCost, PushCost, (TargetSeconds + 59) div 60, (TargetSeconds + 59) rem 60) + MoveCost
    ).

min_cost(StartAt, MoveCost, PushCost, M, S) ->
    if
        M >= 100 ->
            100000000;
        true ->
            Digits = get_digits(M, S),
            case Digits of
                [] ->
                    0;
                [D1, D2, D3, D4] ->
                    cost(StartAt, MoveCost, PushCost, [D1,D2,D3,D4]);
                [D1, D2, D3] ->
                    cost(StartAt, MoveCost, PushCost, [0,D1,D2,D3]);
                [D1, D2] ->
                    cost(StartAt, MoveCost, PushCost, [0,0,D1,D2]);
                [D1] ->
                    cost(StartAt, MoveCost, PushCost, [0,0,0,D1])
            end
    end.

get_digits(M, S) ->
    lists:reverse(get_digits_helper(M * 100 + S, [])).

get_digits_helper(0, Acc) ->
    Acc;
get_digits_helper(N, Acc) ->
    get_digits_helper(N div 10, [N rem 10 | Acc]).

cost(StartAt, MoveCost, PushCost, Digits) ->
    remove_leading_zeros(Digits, StartAt, MoveCost, PushCost, 0).

remove_leading_zeros([0|Rest], StartAt, MoveCost, PushCost, Acc) ->
    remove_leading_zeros(Rest, StartAt, MoveCost, PushCost, Acc);
remove_leading_zeros(Digits, StartAt, MoveCost, PushCost, Acc) ->
    calculate_cost(Digits, StartAt, MoveCost, PushCost, Acc).

calculate_cost([D1|Rest], StartAt, MoveCost, PushCost, Acc) ->
    Move = if D1 == StartAt then 0 else MoveCost end,
    calculate_cost(Rest, D1, MoveCost, PushCost, Acc + Move + PushCost);
calculate_cost([], _, _, _, Acc) ->
    Acc.