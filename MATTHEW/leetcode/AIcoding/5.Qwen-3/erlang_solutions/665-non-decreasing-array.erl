-module(non_decreasing_array).
-export([check_increasing/1]).

check_increasing(Nums) ->
    check_increasing(Nums, 0).

check_increasing([], _) ->
    true;
check_increasing([_], _) ->
    true;
check_increasing([A, B | Rest], Index) ->
    if
        A =< B ->
            check_increasing([B | Rest], Index + 1);
        true ->
            case Index of
                0 ->
                    check_increasing([B | Rest], Index + 1);
                _ ->
                    case [A | Rest] of
                        [X, Y | _] when X > Y ->
                            false;
                        _ ->
                            check_increasing([B | Rest], Index + 1)
                    end
            end
    end.