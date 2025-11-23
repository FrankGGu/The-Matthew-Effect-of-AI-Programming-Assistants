-module(solution).
-export([min_elements/3]).

-spec min_elements(Nums :: [integer()], Limit :: integer(), Goal :: integer()) -> integer().
min_elements(Nums, Limit, Goal) ->
    CurrentSum = lists:foldl(fun(X, Acc) -> Acc + X end, 0, Nums),
    Diff = Goal - CurrentSum,
    AbsDiff = abs(Diff),

    % The minimum number of elements needed is ceil(AbsDiff / Limit).
    % For positive integers A and B, ceil(A/B) can be calculated as (A + B - 1) div B.
    % This formula also correctly handles the case where AbsDiff is 0, resulting in 0.
    (AbsDiff + Limit - 1) div Limit.