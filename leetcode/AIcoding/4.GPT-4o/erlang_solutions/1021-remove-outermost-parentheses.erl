-module(solution).
-export([remove_outer_parentheses/1]).

remove_outer_parentheses(S) ->
    remove_outer_parentheses_helper(S, 0, []).

remove_outer_parentheses_helper([], _, Acc) -> 
    lists:reverse(Acc);
remove_outer_parentheses_helper([H | T], Count, Acc) ->
    case H of
        $'(' ->
            if Count > 0 ->
                remove_outer_parentheses_helper(T, Count + 1, [H | Acc]);
            true ->
                remove_outer_parentheses_helper(T, Count + 1, Acc)
            end;
        $')' ->
            if Count > 1 ->
                remove_outer_parentheses_helper(T, Count - 1, [H | Acc]);
            Count =:= 1 ->
                remove_outer_parentheses_helper(T, Count - 1, Acc)
            end
    end.