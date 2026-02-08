-module(solution).
-export([count_sub_multisets/2]).

count_sub_multisets(Nums, L, R) ->
    Counts = lists:foldl(fun(X, Acc) -> maps:update_with(X, fun(V) -> V + 1 end, 1, Acc) end, #{}, Nums),
    Items = lists:sort(maps:to_list(Counts)),
    solve(Items, L, R, 1).

solve([], L, R, Mod) ->
    (R div 1) - ((L - 1) div 1) + 1.

solve([{0, Count} | Rest], L, R, Mod) ->
    solve(Rest, L, R, Mod) * (Count + 1) rem Mod;

solve([{Num, Count} | Rest], L, R, Mod) ->
    lists:foldl(fun(Sum, Acc) ->
        if Sum > R then
            Acc
        else
            Acc + solve_helper(Rest, L - Sum, R - Sum, Mod, Num, Count) rem Mod
        end
    end, 0, lists:seq(0, Num * Count)).

solve_helper([], L, R, Mod, _, _) ->
    (R div 1) - ((L - 1) div 1) + 1;

solve_helper([{0, Count} | Rest], L, R, Mod, _, _) ->
    solve_helper(Rest, L, R, Mod, _, _) * (Count + 1) rem Mod;

solve_helper([{Num, Count} | Rest], L, R, Mod, OrigNum, OrigCount) ->
    lists:foldl(fun(Sum, Acc) ->
        if Sum > R then
            Acc
        else
            Acc + solve_helper(Rest, L - Sum, R - Sum, Mod, Num, Count) rem Mod
        end
    end, 0, lists:seq(0, Num * Count)).