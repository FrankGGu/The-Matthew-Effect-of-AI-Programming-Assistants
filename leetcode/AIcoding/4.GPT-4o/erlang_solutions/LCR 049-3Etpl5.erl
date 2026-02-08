-module(solution).
-export([sum_numbers/1]).

sum_numbers(Root) ->
    sum_helper(Root, 0).

sum_helper(nil, _) ->
    0;
sum_helper({Value, Left, Right}, CurrentSum) ->
    NewSum = CurrentSum * 10 + Value,
    case {Left, Right} of
        {nil, nil} -> NewSum;
        _ -> sum_helper(Left, NewSum) + sum_helper(Right, NewSum)
    end.