-module(solver).
-export([sum_numbers/1]).

sum_numbers(Root) ->
    sum_numbers(Root, 0).

sum_numbers(nil, _) ->
    0;
sum_numbers(#{} = Node, Current) ->
    CurrentVal = maps:get(value, Node),
    NewCurrent = Current * 10 + CurrentVal,
    Left = maps:get(left, Node, nil),
    Right = maps:get(right, Node, nil),
    case {Left, Right} of
        {nil, nil} ->
            NewCurrent;
        _ ->
            sum_numbers(Left, NewCurrent) + sum_numbers(Right, NewCurrent)
    end.