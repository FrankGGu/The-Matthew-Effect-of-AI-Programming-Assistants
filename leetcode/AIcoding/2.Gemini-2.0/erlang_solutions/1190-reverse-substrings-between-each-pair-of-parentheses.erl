-module(reverse_parentheses).
-export([reverse_parentheses/1]).

reverse_parentheses(S) ->
    reverse_parentheses_helper(string:to_list(S), []).

reverse_parentheses_helper([], Acc) ->
    list_to_binary(lists:reverse(Acc));
reverse_parentheses_helper([$( | Rest], Acc) ->
    {Reversed, Remaining} = find_matching_and_reverse(Rest, []),
    reverse_parentheses_helper(Remaining, Acc ++ Reversed);
reverse_parentheses_helper([H | Rest], Acc) ->
    reverse_parentheses_helper(Rest, [H | Acc]).

find_matching_and_reverse([], Acc) ->
    {lists:reverse(Acc), []};
find_matching_and_reverse([$) | Rest], Acc) ->
    {lists:reverse(Acc), Rest};
find_matching_and_reverse([$( | Rest], Acc) ->
    {Reversed, Remaining} = find_matching_and_reverse(Rest, []),
    find_matching_and_reverse(Remaining, Acc ++ Reversed);
find_matching_and_reverse([H | Rest], Acc) ->
    find_matching_and_reverse(Rest, [H | Acc]).