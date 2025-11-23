-spec minimum_mountain_removals(Nums :: [integer()]) -> integer().
minimum_mountain_removals(Nums) ->
    N = length(Nums),
    Left = lists:duplicate(N, 1),
    Right = lists:duplicate(N, 1),

    % Calculate left LIS
    Left1 = calculate_left_lis(Nums, Left, 1, N),

    % Calculate right LIS
    Right1 = calculate_right_lis(Nums, Right, N, 1),

    % Find the maximum mountain length
    Max = find_max_mountain(Left1, Right1, N),

    N - Max.

calculate_left_lis(_, Left, I, N) when I > N -> Left;
calculate_left_lis(Nums, Left, I, N) ->
    Num = lists:nth(I, Nums),
    MaxLen = lists:max([0 | [lists:nth(J, Left) || J <- lists:seq(1, I-1), lists:nth(J, Nums) < Num]]),
    NewLeft = set_element(I, Left, MaxLen + 1),
    calculate_left_lis(Nums, NewLeft, I + 1, N).

calculate_right_lis(_, Right, I, _) when I < 1 -> Right;
calculate_right_lis(Nums, Right, I, N) ->
    Num = lists:nth(I, Nums),
    MaxLen = lists:max([0 | [lists:nth(J, Right) || J <- lists:seq(I+1, N), lists:nth(J, Nums) < Num]]),
    NewRight = set_element(I, Right, MaxLen + 1),
    calculate_right_lis(Nums, NewRight, I - 1, N).

find_max_mountain(Left, Right, N) ->
    lists:max([lists:nth(I, Left) + lists:nth(I, Right) - 1 || I <- lists:seq(1, N), lists:nth(I, Left) > 1, lists:nth(I, Right) > 1]).

set_element(1, [_|T], Val) -> [Val|T];
set_element(Idx, [H|T], Val) -> [H|set_element(Idx-1, T, Val)].