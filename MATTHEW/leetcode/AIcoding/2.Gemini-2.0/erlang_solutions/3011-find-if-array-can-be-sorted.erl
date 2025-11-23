-module(can_be_sorted).
-export([solve/1]).

solve(Nums) ->
    solve_helper(Nums, []).

solve_helper([], Acc) ->
    is_sorted(lists:reverse(Acc));
solve_helper([H | T], Acc) ->
    case Acc of
        [] ->
            solve_helper(T, [H]);
        [A | _] ->
            if H rem 2 == A rem 2 ->
                solve_helper(T, [H | Acc]);
            true ->
                solve_helper(T, [H] ++ Acc)
            end
    end.

is_sorted([]) -> true;
is_sorted([_]) -> true;
is_sorted([A, B | T]) ->
    if A =< B ->
        is_sorted([B | T]);
    true ->
        false
    end.