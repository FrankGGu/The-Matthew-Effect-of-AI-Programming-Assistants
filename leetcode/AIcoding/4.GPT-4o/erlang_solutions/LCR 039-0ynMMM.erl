-module(solution).
-export([largestRectangleArea/1]).

largestRectangleArea(Heights) ->
    largestRectangleArea(Heights, 0, []).

largestRectangleArea([], Max, Stack) ->
    Max;
largestRectangleArea([H | T], Max, Stack) ->
    {NewMax, NewStack} = process(H, Max, Stack, length(Heights) - length(T)),
    largestRectangleArea(T, NewMax, NewStack).

process(H, Max, [], Index) ->
    {Max, [{H, Index}]};
process(H, Max, [{TopH, TopIndex} | Rest], Index) when TopH <= H ->
    process(H, Max, Rest, Index);
process(H, Max, Stack, Index) ->
    {TopH, TopIndex} = hd(Stack),
    NewMax = max(Max, TopH * (Index - TopIndex)),
    process(H, NewMax, tl(Stack), TopIndex).

max(A, B) when A > B -> A;
max(_, B) -> B.