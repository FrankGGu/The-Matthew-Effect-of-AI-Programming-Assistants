-module(solution).
-export([reverse_parentheses/1]).

reverse_parentheses(S) ->
    reverse_parentheses(S, []).

reverse_parentheses([], Acc) ->
    lists:reverse(Acc);
reverse_parentheses([H | T], Acc) ->
    case H of
        $) -> 
            {Rev, Rest} = reverse_until_open(Acc, []),
            reverse_parentheses(Rest ++ Rev);
        $( -> 
            reverse_parentheses(T ++ [H | Acc]);
        _ -> 
            reverse_parentheses(T, [H | Acc])
    end.

reverse_until_open([], Acc) ->
    {lists:reverse(Acc), []};
reverse_until_open([$ ( | T], Acc) ->
    {lists:reverse(Acc), [$ ( | T]};
reverse_until_open([H | T], Acc) ->
    reverse_until_open(T, [H | Acc]).