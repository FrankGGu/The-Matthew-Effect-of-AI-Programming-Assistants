-module(left_right_sum_differences).
-export([leftRightDifference/1]).

leftRightSumDifferences([]) -> [];
leftRightSumDifferences([H|T]) ->
    Left = 0,
    Right = lists:sum(T),
    [Left - Right | leftRightSumDifferences(T, H, Right)].

leftRightSumDifferences([], _, _) -> [];
leftRightSumDifferences([H|T], PrevLeft, Right) ->
    NewLeft = PrevLeft + H,
    NewRight = Right - H,
    [NewLeft - NewRight | leftRightSumDifferences(T, NewLeft, NewRight)].