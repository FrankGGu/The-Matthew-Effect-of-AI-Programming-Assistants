-module(remove_invalid_parentheses).
-export([remove_invalid_parentheses/1]).

remove_invalid_parentheses(S) ->
    remove_invalid_parentheses(S, 0, 0, [], []).

remove_invalid_parentheses([], _, _, Acc, _) ->
    lists:reverse(Acc);
remove_invalid_parentheses([H | T], Open, Close, Acc, Stack) ->
    case H of
        $() ->
            if
                Open > Close ->
                    remove_invalid_parentheses(T, Open + 1, Close, [H | Acc], [H | Stack]);
                true ->
                    remove_invalid_parentheses(T, Open, Close, Acc, Stack)
            end;
        $) ->
            if
                Open > Close ->
                    remove_invalid_parentheses(T, Open, Close + 1, [H | Acc], [H | Stack]);
                true ->
                    remove_invalid_parentheses(T, Open, Close, Acc, Stack)
            end;
        _ ->
            remove_invalid_parentheses(T, Open, Close, [H | Acc], Stack)
    end.