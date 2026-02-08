-module(solution).
-export([min_add_to_make_valid/1]).

min_add_to_make_valid(S) ->
    Parentheses = lists:foldl(fun(Char, {Open, Close}) ->
        case Char of
            $( -> {Open + 1, Close};
            $) -> case Open > 0 of
                        true -> {Open - 1, Close};
                        false -> {Open, Close + 1}
                    end;
            _ -> {Open, Close}
        end
    end, {0, 0}, string:to_list(S)),
    tuple:element(1, Parentheses) + tuple:element(2, Parentheses).