-module(solution).
-export([longest_valid_parentheses/1]).

longest_valid_parentheses(Str) ->
    Parentheses = string:to_list(Str),
    longest(Parentheses, 0, 0, 0, 0).

longest([], Max, _, _, _) -> Max;
longest([H | T], Max, Left, Right, Count) when H =:= $\( -> 
    longest(T, Max, Left + 1, Right, Count);
longest([H | T], Max, Left, Right, Count) when H =:= $\) -> 
    NewCount = if
        Left > 0 -> Count + 2;
        true -> Count
    end,
    NewLeft = if
        Left > 0 -> Left - 1;
        true -> Left
    end,
    longest(T, max(Max, NewCount), NewLeft, Right + 1, NewCount);
longest([_ | T], Max, Left, Right, Count) -> 
    longest(T, Max, 0, 0, Count).