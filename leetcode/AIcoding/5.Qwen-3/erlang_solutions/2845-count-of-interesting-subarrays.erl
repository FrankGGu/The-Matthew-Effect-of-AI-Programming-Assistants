-module(count_of_interesting_subarrays).
-export([solve/1]).

solve(Nums) ->
    solve(Nums, 0, 0, 0).

solve([], _, _, Count) ->
    Count;
solve([H | T], Index, Sum, Count) ->
    NewSum = Sum + H,
    if
        NewSum rem 3 == 0 ->
            solve(T, Index + 1, NewSum, Count + 1);
        true ->
            solve(T, Index + 1, NewSum, Count)
    end.