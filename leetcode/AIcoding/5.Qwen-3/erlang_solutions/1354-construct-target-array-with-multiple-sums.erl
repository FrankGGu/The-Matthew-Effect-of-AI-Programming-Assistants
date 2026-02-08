-module(target_array).
-export([is_possible/2]).

is_possible(Nums, Target) ->
    is_possible(Nums, Target, 0, 0).

is_possible([], [], _, _) -> true;
is_possible([], _, _, _) -> false;
is_possible(_, [], _, _) -> false;
is_possible(Nums, Target, Sum, Index) ->
    [N | Tn] = Nums,
    [T | Tt] = Target,
    case Sum + N of
        S when S == T ->
            is_possible(Tn, Tt, 0, Index + 1);
        S when S < T ->
            is_possible(Tn, Target, S, Index + 1);
        _ ->
            false
    end.