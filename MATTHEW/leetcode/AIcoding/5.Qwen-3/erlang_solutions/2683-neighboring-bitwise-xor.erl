-module(neighboring_bitwise_xor).
-export([solve/1]).

solve(Nums) ->
    solve(Nums, 0).

solve([], _), -> 0;
solve([_], _), -> 0;
solve([A, B | Rest], Index) ->
    case (A band B) of
        1 -> solve([B | Rest], Index + 1);
        _ -> solve([B | Rest], Index)
    end.