-module(reverse_substrings_between_each_pair_of_parentheses).
-export([reverseParentheses/1]).

reverseParentheses(S) ->
    reverse_parentheses(S, [], []).

reverse_parentheses([], [], Acc) ->
    lists:reverse(Acc);
reverse_parentheses([], Stack, Acc) ->
    reverse_parentheses([], [], lists:append(lists:reverse(Stack), Acc));
reverse_parentheses([$( | Rest], Stack, Acc) ->
    reverse_parentheses(Rest, [Acc | Stack], []);
reverse_parentheses([$) | Rest], [Current | Stack], Acc) ->
    reverse_parentheses(Rest, Stack, lists:append(lists:reverse(Current), Acc));
reverse_parentheses([C | Rest], Stack, Acc) ->
    reverse_parentheses(Rest, Stack, [C | Acc]).