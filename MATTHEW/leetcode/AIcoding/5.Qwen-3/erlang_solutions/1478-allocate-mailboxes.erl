-module(allocate_mailboxes).
-export([solve/1]).

solve(Houses) ->
    solve(Houses, 0, 0, 0, 0, []).

solve([], _, _, _, _, Acc) ->
    lists:reverse(Acc);
solve([H | T], K, I, Cost, Total, Acc) ->
    case I of
        0 ->
            solve(T, K, 1, H, Total, Acc);
        _ ->
            NewCost = cost(H, lists:last(Acc)),
            solve(T, K, I + 1, H, Total + NewCost, [H | Acc])
    end.

cost(A, B) ->
    abs(A - B).