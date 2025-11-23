-module(solution).
-export([remove_outermost_parentheses/1]).

remove_outermost_parentheses(S) ->
    remove_outermost_parentheses_recursive(S, 0, []).

remove_outermost_parentheses_recursive([], _Balance, Acc) ->
    lists:reverse(Acc);
remove_outermost_parentheses_recursive([$(|T], Balance, Acc) ->
    NewBalance = Balance + 1,
    case Balance > 0 of
        true ->
            remove_outermost_parentheses_recursive(T, NewBalance, [$(|Acc]);
        false ->
            remove_outermost_parentheses_recursive(T, NewBalance, Acc)
    end;
remove_outermost_parentheses_recursive([$)|T], Balance, Acc) ->
    NewBalance = Balance - 1,
    case NewBalance > 0 of
        true ->
            remove_outermost_parentheses_recursive(T, NewBalance, [$)|Acc]);
        false ->
            remove_outermost_parentheses_recursive(T, NewBalance, Acc)
    end.