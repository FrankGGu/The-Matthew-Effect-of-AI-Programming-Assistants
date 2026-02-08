-module(solution).
-export([cherry_pickup/1]).

-define(MIN_INT, -1000000000).

cherry_pickup(Grid) ->
    N = length(Grid),
    {Result, _FinalMemo} = solve_memo(Grid, N, 0, 0, 0, maps:new()),
    max(0, Result).

solve_memo(Grid, N, S, R1, R2, Memo) ->
    C1 = S - R1,
    C2 = S - R2,

    %% Boundary and Thorn checks
    if R1 < 0 orelse R1 >= N orelse C1 < 0 orelse C1 >= N orelse
       R2 < 0 orelse R2 >= N orelse C2 < 0 orelse C2 >= N orelse
       lists:nth(C1 + 1, lists:nth(R1 + 1, Grid)) == -1 orelse
       lists:nth(C2 + 1, lists:nth(R2 + 1, Grid)) == -1
    then
        {?MIN_INT, Memo}
    %% Memoization check
    else if maps:is_key({S, R1, R2}, Memo)
    then
        {maps:get({S, R1, R2}, Memo), Memo}
    %% Base case: both robots reached the bottom-right cell
    else if S == 2 * (N - 1)
    then
        Val = lists:nth(C1 + 1, lists:nth(R1 + 1, Grid)),
        NewMemo = maps:put({S, R1, R2}, Val, Memo),
        {Val, NewMemo}
    %% Recursive step
    else
        Val1 = lists:nth(C1 + 1, lists:nth(R1 + 1, Grid)),
        Val2 = lists:nth(C2 + 1, lists:nth(R2 + 1, Grid)),
        CurrentCherries = Val1 + (if R1 == R2 -> 0; true -> Val2 end),

        %% Explore all 4 possible next moves for the two robots
        %% Robot 1 (R1, C1) can move to (R1+1, C1) or (R1, C1+1)
        %% Robot 2 (R2, C2) can move to (R2+1, C2) or (R2, C2+1)
        %% S increments by 1 for each step (R+C increases by 1)

        %% DD: Robot1 moves Down, Robot2 moves Down
        {Res_dd, Memo_dd} = solve_memo(Grid, N, S + 1, R1 + 1, R2 + 1, Memo),
        %% DR: Robot1 moves Down, Robot2 moves Right
        {Res_dr, Memo_dr} = solve_memo(Grid, N, S + 1, R1 + 1, R2, Memo_dd),
        %% RD: Robot1 moves Right, Robot2 moves Down
        {Res_rd, Memo_rd} = solve_memo(Grid, N, S + 1, R1, R2 + 1, Memo_dr),
        %% RR: Robot1 moves Right, Robot2 moves Right
        {Res_rr, Memo_rr} = solve_memo(Grid, N, S + 1, R1, R2, Memo_rd),

        MaxFutureCherries = lists:max([Res_dd, Res_dr, Res_rd, Res_rr]),

        Result = if MaxFutureCherries == ?MIN_INT
                 then ?MIN_INT
                 else CurrentCherries + MaxFutureCherries
                 end,

        FinalMemo = maps:put({S, R1, R2}, Result, Memo_rr),
        {Result, FinalMemo}
    end end end.