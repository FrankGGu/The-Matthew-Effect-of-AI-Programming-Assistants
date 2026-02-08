-module(solution).
-export([sum_numbers/1]).

-sum_numbers(Node) ->
    sum_numbers(Node, 0).

sum_numbers(null, _) ->
    0;
sum_numbers({Val, Left, Right}, Prefix) ->
    Current = Prefix * 10 + Val,
    case {Left, Right} of
        {null, null} ->
            Current;
        _ ->
            sum_numbers(Left, Current) + sum_numbers(Right, Current)
    end.