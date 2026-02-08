-module(kth_smallest_instructions).
-export([find_instruction/2]).

find_instruction(R, K) ->
    find_instruction(R, K, 0, 0).

find_instruction(R, K, x, y) ->
    if
        x == R#r.x and y == R#r.y ->
            [];
        true ->
            Left = R#r.x - x,
            Down = R#r.y - y,
            Total = Left + Down,
            Count = combination(Total, Left),
            if
                K > Count ->
                    [d | find_instruction(R, K - Count, x, y + 1)];
                true ->
                    [l | find_instruction(R, K, x + 1, y)]
            end
    end.

combination(N, K) when N < K -> 0;
combination(N, 0) -> 1;
combination(N, K) ->
    combination(N, K, 1).

combination(N, K, Acc) when K == 0 -> Acc;
combination(N, K, Acc) ->
    combination(N - 1, K - 1, Acc * N div K).