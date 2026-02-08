-module(solution).
-export([min_add_to_make_valid/1]).

min_add_to_make_valid(S) ->
    lists:foldl(fun(C, {Open, Close}) ->
        case C of
            $'(' -> {Open + 1, Close};
            $')' -> 
                if Open > 0 -> {Open - 1, Close};
                true -> {Open, Close + 1}
                end
        end
    end, {0, 0}, string:to_list(S)),
    element(1, {0, 0}) + element(2, {0, 0}).