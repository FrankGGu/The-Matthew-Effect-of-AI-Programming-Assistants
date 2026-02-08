-module(solution).
-export([max_cost/2]).

max_cost(S, K) ->
    max_cost(S, K, 0, 0, 0, 0).

max_cost([], _, _, _, Max, _) ->
    Max;
max_cost([H | T], K, Index, CurrentCost, Max, Start) ->
    case H of
        $A -> CurrentCost1 = CurrentCost + 1;
        $B -> CurrentCost1 = CurrentCost + 2;
        $C -> CurrentCost1 = CurrentCost + 3;
        _ -> CurrentCost1 = CurrentCost
    end,
    if
        Index - Start + 1 > K ->
            case S[Start] of
                $A -> CurrentCost1 = CurrentCost1 - 1;
                $B -> CurrentCost1 = CurrentCost1 - 2;
                $C -> CurrentCost1 = CurrentCost1 - 3;
                _ -> CurrentCost1 = CurrentCost1
            end,
            Start1 = Start + 1,
            max_cost(T, K, Index + 1, CurrentCost1, Max, Start1);
        true ->
            Max1 = max(Max, CurrentCost1),
            max_cost(T, K, Index + 1, CurrentCost1, Max1, Start)
    end.