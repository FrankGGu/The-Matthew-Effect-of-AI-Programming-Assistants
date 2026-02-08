-module(solution).
-export([judge_point24/1]).

judge_point24(Nums) ->
    case solve(Nums) of
        true -> true;
        false -> false
    end.

solve([X]) ->
    abs(X - 24.0) < 0.0001;
solve(Nums) ->
    {L1, L2} = lists:split(1, Nums),
    [A] = L1,
    Rest = L2,
    solve([A + B || B <- Rest] ++ [A - B || B <- Rest] ++ [B - A || B <- Rest] ++
          [A * B || B <- Rest] ++ [A / B || B <- Rest, B /= 0] ++ [B / A || B <- Rest, A /= 0]) orelse
    solve([B + A || B <- Rest] ++ [B - A || B <- Rest] ++ [A - B || B <- Rest] ++
          [B * A || B <- Rest] ++ [B / A || B <- Rest, A /= 0] ++ [A / B || B <- Rest, B /= 0]) orelse
    (case lists:split(2, Nums) of
        {L3, L4} ->
            [B, C] = L3,
            Rest2 = L4,
            solve([B + C | Rest2] ++ [B - C | Rest2] ++ [C - B | Rest2] ++
                  [B * C | Rest2] ++ [B / C | Rest2] ++ [C / B | Rest2])
    end).