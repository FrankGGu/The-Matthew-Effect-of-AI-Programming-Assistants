-module(solution).
-export([maximum_beauty/2]).

maximum_beauty(Nums, K) ->
    SortedNums = lists:sort(Nums),
    N = length(SortedNums),
    TwoK = 2 * K,

    Left = 0,
    Ans = 0,

    maximum_beauty_loop(0, N, SortedNums, TwoK, Left, Ans).

maximum_beauty_loop(Right, N, SortedNums, TwoK, Left, Ans) when Right < N ->
    % Advance Left pointer if the window [Left+1 ... Right] is too wide
    % This means nums[Right] - nums[Left+1] > TwoK
    % We need Left < Right to ensure Left+1 is a valid index
    NewLeft = advance_left(Left, Right, SortedNums, TwoK),

    CurrentNum = lists:nth(Right + 1, SortedNums), % Erlang lists are 1-indexed
    LeftNum = lists:nth(NewLeft + 1, SortedNums),

    CurrentAns = 
        if CurrentNum - LeftNum =< TwoK ->
            % Window [NewLeft ... Right] is beautiful without any skip
            % or with skipping an element before NewLeft.
            % Length is Right - NewLeft + 1.
            max(Ans, Right - NewLeft + 1);
        true ->
            % Window [NewLeft ... Right] is too wide (CurrentNum - LeftNum > TwoK).
            % This implies we must use the operation.
            % Due to the while loop, we know CurrentNum - nums[NewLeft+1] <= TwoK (if NewLeft < Right).
            % So, the beautiful window is [NewLeft+1 ... Right] (by skipping nums[NewLeft]).
            % Its length is Right - (NewLeft+1) + 1 = Right - NewLeft.
            % If NewLeft = Right, length is 0 (empty window after skip), but Right-NewLeft+1 handles single element.
            % The length will be 0 if NewLeft = Right, which is correct for a skip.
            max(Ans, Right - NewLeft)
        end,

    maximum_beauty_loop(Right + 1, N, SortedNums, TwoK, NewLeft, CurrentAns);

maximum_beauty_loop(_Right, _N, _SortedNums, _TwoK, _Left, Ans) ->
    Ans.

advance_left(Left, Right, SortedNums, TwoK) ->
    advance_left_loop(Left, Right, SortedNums, TwoK).

advance_left_loop(CurrentLeft, Right, SortedNums, TwoK) when CurrentLeft < Right ->
    CurrentNum = lists:nth(Right + 1, SortedNums),
    NextLeftNum = lists:nth(CurrentLeft + 1 + 1, SortedNums), % nums[CurrentLeft+1]

    if CurrentNum - NextLeftNum > TwoK ->
        % If window [CurrentLeft+1 ... Right] is too wide, advance CurrentLeft
        advance_left_loop(CurrentLeft + 1, Right, SortedNums, TwoK);
    true ->
        % Window [CurrentLeft+1 ... Right] is beautiful, or CurrentLeft is already at Right
        CurrentLeft
    end;
advance_left_loop(CurrentLeft, _Right, _SortedNums, _TwoK) ->
    % If CurrentLeft = Right, we can't check CurrentLeft+1, so stop.
    CurrentLeft.