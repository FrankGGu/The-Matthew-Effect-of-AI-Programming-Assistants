-module(solution).
-export([minCost/4]).

minCost(TargetSeconds, StartDigit, MoveCost, PushCost) ->
    M1 = TargetSeconds div 60,
    S1 = TargetSeconds rem 60,

    MinCost = 1000000000,

    Cost1 = if
                M1 =< 99 ->
                    Digits1 = format_and_convert_to_digits(M1, S1),
                    calculate_cost(Digits1, StartDigit, MoveCost, PushCost);
                true -> MinCost
            end,

    M2 = M1 - 1,
    S2 = S1 + 60,
    Cost2 = if
                M2 >= 0 andalso S2 =< 99 ->
                    Digits2 = format_and_convert_to_digits(M2, S2),
                    calculate_cost(Digits2, StartDigit, MoveCost, PushCost);
                true -> MinCost
            end,

    min(Cost1, Cost2).

format_and_convert_to_digits(M, S) ->
    [C - $0 || C <- io_lib:format("~2.0B~2.0B", [M, S])].

calculate_cost(Digits, CurrentDigit, MoveCost, PushCost) ->
    calculate_cost_recursive(Digits, CurrentDigit, MoveCost, PushCost, 0).

calculate_cost_recursive([], _CurrentDigit, _MoveCost, _PushCost, AccCost) ->
    AccCost;
calculate_cost_recursive([H|T], CurrentDigit, MoveCost, PushCost, AccCost) ->
    NewCost = if
                  H == CurrentDigit -> PushCost;
                  true -> MoveCost + PushCost
              end,
    calculate_cost_recursive(T, H, MoveCost, PushCost, AccCost + NewCost).