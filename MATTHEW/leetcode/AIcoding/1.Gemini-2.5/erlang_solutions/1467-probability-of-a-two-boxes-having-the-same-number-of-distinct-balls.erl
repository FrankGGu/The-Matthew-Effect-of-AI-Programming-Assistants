-module(solution).
-export([get_probability/1]).

-spec combinations(N :: integer(), K :: integer()) -> integer().
combinations(N, K) when K < 0; K > N -> 0;
combinations(N, K) when K == 0; K == N -> 1;
combinations(N, K) when K > N div 2 -> combinations(N, N - K);
combinations(N, K) ->
    combinations_iter(N, K, 1).

combinations_iter(Num, Den, Acc) when Den > 0 ->
    combinations_iter(Num - 1, Den - 1, Acc * Num div Den);
combinations_iter(_Num, _Den, Acc) ->
    Acc.

-spec get_probability(Balls :: [integer()]) -> float().
get_probability(Balls) ->
    TotalBalls = lists:sum(Balls),
    TargetBallsPerBox = TotalBalls div 2,
    K = length(Balls),

    % Denominator: Total ways to choose TargetBallsPerBox balls for Box 1
    Denominator = combinations(TotalBalls, TargetBallsPerBox),

    % Numerator: Favorable ways using recursion with memoization
    % State: {Idx, Box1Balls, Box2Balls, Box1Distinct, Box2Distinct}
    % Idx: current ball color index (0 to K-1)
    % Box1Balls: current total balls in Box 1
    % Box2Balls: current total balls in Box 2
    % Box1Distinct: current distinct colors in Box 1
    % Box2Distinct: current distinct colors in Box 2
    Memo = #{}, % Initial memoization map
    {Numerator, _FinalMemo} = solve(0, 0, 0, 0, 0, K, TargetBallsPerBox, Balls, Memo),

    case Denominator of
        0 -> 0.0; % Should not happen based on problem constraints (sum(balls) is always even and >= 1)
        _ -> Numerator / Denominator
    end.

-spec solve(Idx :: integer(), Box1Balls :: integer(), Box2Balls :: integer(),
            Box1Distinct :: integer(), Box2Distinct :: integer(),
            K :: integer(), TargetBallsPerBox :: integer(), Balls :: [integer()],
            Memo :: map()) -> {integer(), map()}.
solve(Idx, Box1Balls, Box2Balls, Box1Distinct, Box2Distinct, K, TargetBallsPerBox, Balls, Memo) ->
    Key = {Idx, Box1Balls, Box2Balls, Box1Distinct, Box2Distinct},
    case maps:get(Key, Memo, undefined) of
        undefined ->
            % Calculate and store the result
            {Res, UpdatedMemo} = calculate_solve(Idx, Box1Balls, Box2Balls, Box1Distinct, Box2Distinct, K, TargetBallsPerBox, Balls, Memo),
            {Res, maps:put(Key, Res, UpdatedMemo)};
        Val ->
            % Return cached value
            {Val, Memo}
    end.

-spec calculate_solve(Idx :: integer(), Box1Balls :: integer(), Box2Balls :: integer(),
                     Box1Distinct :: integer(), Box2Distinct :: integer(),
                     K :: integer(), TargetBallsPerBox :: integer(), Balls :: [integer()],
                     Memo :: map()) -> {integer(), map()}.
calculate_solve(Idx, Box1Balls, Box2Balls, Box1Distinct, Box2Distinct, K, TargetBallsPerBox, Balls, Memo) ->
    % Pruning: If either box exceeds its target ball count, this path is invalid.
    if
        Box1Balls > TargetBallsPerBox;
        Box2Balls > TargetBallsPerBox ->
            {0, Memo}; % Return 0 ways, memo unchanged
        true ->
            % Base case: All ball colors have been processed.
            if
                Idx == K ->
                    % Check if both boxes have the target number of balls and same distinct colors.
                    if
                        Box1Balls == TargetBallsPerBox andalso Box1Distinct == Box2Distinct ->
                            {1, Memo}; % Valid distribution, return 1 way, memo unchanged
                        true ->
                            {0, Memo} % Invalid distribution, return 0 ways
                    end;
                true ->
                    % Recursive step: Process current ball color.
                    CurrentBallCount = lists:nth(Idx + 1, Balls), % Balls list is 1-indexed for lists:nth
                    % Iterate through all possible distributions of CurrentBallCount balls for the current color.
                    % J: number of balls of CurrentBallCount type going into Box 1.
                    iterate_j(0, CurrentBallCount, Idx, Box1Balls, Box2Balls, Box1Distinct, Box2Distinct, K, TargetBallsPerBox, Balls, 0, Memo)
            end
    end.

-spec iterate_j(J :: integer(), CurrentBallCount :: integer(), Idx :: integer(),
               Box1Balls :: integer(), Box2Balls :: integer(),
               Box1Distinct :: integer(), Box2Distinct :: integer(),
               K :: integer(), TargetBallsPerBox :: integer(), Balls :: [integer()],
               AccWays :: integer(), Memo :: map()) -> {integer(), map()}.
iterate_j(J, CurrentBallCount, Idx, Box1Balls, Box2Balls, Box1Distinct, Box2Distinct, K, TargetBallsPerBox, Balls, AccWays, Memo) when J =< CurrentBallCount ->
    % Determine if current color adds to distinct count for each box.
    NewBox1Distinct = if J > 0 -> Box1Distinct + 1; true -> Box1Distinct end,
    NewBox2Distinct = if CurrentBallCount - J > 0 -> Box2Distinct + 1; true -> Box2Distinct end,

    % Calculate combinations for distributing J balls of current color to Box 1.
    WaysToChooseJ = combinations(CurrentBallCount, J),

    % Recursive call to solve for the next ball color with updated state.
    {SubWays, UpdatedMemo} = solve(Idx + 1, Box1Balls + J, Box2Balls + CurrentBallCount - J, NewBox1Distinct, NewBox2Distinct, K, TargetBallsPerBox, Balls, Memo),

    % Continue iteration for the next value of J.
    iterate_j(J + 1, CurrentBallCount, Idx, Box1Balls, Box2Balls, Box1Distinct, Box2Distinct, K, TargetBallsPerBox, Balls, AccWays + WaysToChooseJ * SubWays, UpdatedMemo);
iterate_j(_J, _CurrentBallCount, _Idx, _Box1Balls, _Box2Balls, _Box1Distinct, _Box2Distinct, _K, _TargetBallsPerBox, _Balls, AccWays, Memo) ->
    % Base case for iteration: all J values processed for current color.
    {AccWays, Memo}.