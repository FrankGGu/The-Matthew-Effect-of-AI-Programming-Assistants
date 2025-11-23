-module(remove_outermost_parentheses).
-export([remove_outer_parentheses/1]).

remove_outer_parentheses(S) ->
    remove_outer_parentheses(S, 0, []).

remove_outer_parentheses([], _, Result) ->
    lists:reverse(Result);
remove_outer_parentheses([$( | Rest], Depth, Result) ->
    if
        Depth == 0 ->
            remove_outer_parentheses(Rest, Depth + 1, Result);
        true ->
            remove_outer_parentheses(Rest, Depth + 1, [$( | Result])
    end;
remove_outer_parentheses([$) | Rest], Depth, Result) ->
    if
        Depth == 1 ->
            remove_outer_parentheses(Rest, Depth - 1, Result);
        true ->
            remove_outer_parentheses(Rest, Depth - 1, [$) | Result])
    end.