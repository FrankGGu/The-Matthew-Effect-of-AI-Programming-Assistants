-module(solution).
-export([apply_operations/2]).

apply_operations(Nums, K) ->
    apply_operations(Nums, K, 0).

apply_operations([], _, _) ->
    true;
apply_operations(Nums, K, Acc) ->
    case Nums of
        [H | T] ->
            Diff = H - Acc,
            if
                Diff =:= 0 ->
                    apply_operations(T, K, Acc);
                Diff > 0 ->
                    Len = length(Nums),
                    if
                        Len < K ->
                            false;
                        true ->
                            apply_operations(T, K, Acc + Diff)
                    end;
                true ->
                    false
            end
    end.