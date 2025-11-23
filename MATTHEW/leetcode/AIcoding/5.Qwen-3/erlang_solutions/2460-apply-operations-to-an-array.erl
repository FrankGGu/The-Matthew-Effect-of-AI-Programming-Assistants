-module(solution).
-export([apply_operations/1]).

apply_operations(Nums) ->
    apply_operations(Nums, []).

apply_operations([], Result) ->
    lists:reverse(Result);
apply_operations([H | T], Result) ->
    case T of
        [] ->
            apply_operations([], [H | Result]);
        _ ->
            case lists:nth(1, T) of
                H ->
                    apply_operations(lists:nthtail(2, T), [H * 2 | Result]);
                _ ->
                    apply_operations(T, [H | Result])
            end
    end.