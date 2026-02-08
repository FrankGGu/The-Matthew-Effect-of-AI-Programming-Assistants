-module(solution).
-export([find_second_minimum/1]).

-record(node, {val, left = null, right = null}).

find_second_minimum(Root) ->
    case Root of
        null -> -1;
        #node{val = Val, left = Left, right = Right} ->
            SecondMin = find_second_minimum_helper(Left, Right, Val),
            case SecondMin of
                infinity -> -1;
                _ -> SecondMin
            end
    end.

find_second_minimum_helper(null, null, _) -> infinity;
find_second_minimum_helper(#node{val = Val1, left = L1, right = R1}, null, Min) ->
    if
        Val1 > Min -> Val1;
        true -> find_second_minimum_helper(L1, R1, Min)
    end;
find_second_minimum_helper(null, #node{val = Val2, left = L2, right = R2}, Min) ->
    if
        Val2 > Min -> Val2;
        true -> find_second_minimum_helper(L2, R2, Min)
    end;
find_second_minimum_helper(#node{val = Val1, left = L1, right = R1}, 
                            #node{val = Val2, left = L2, right = R2}, Min) ->
    case {Val1 > Min, Val2 > Min} of
        {true, true} -> min(Val1, Val2);
        {true, false} -> find_second_minimum_helper(L1, R1, Min);
        {false, true} -> find_second_minimum_helper(L2, R2, Min);
        _ -> find_second_minimum_helper(L1, R1, Min)
    end.

min(X, Y) -> if X < Y -> X; true -> Y end.