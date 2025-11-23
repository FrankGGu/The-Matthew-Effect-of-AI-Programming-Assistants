-module(longest_valid_parentheses).
-export([longest_valid_parentheses/1]).

longest_valid_parentheses(S) ->
    longest_valid_parentheses(S, 0, 0, 0).

longest_valid_parentheses([], _, _, Max) ->
    Max;
longest_valid_parentheses([$( | T], Open, Close, Max) ->
    longest_valid_parentheses(T, Open + 1, Close, Max);
longest_valid_parentheses([$) | T], Open, Close, Max) ->
    if
        Open > Close ->
            longest_valid_parentheses(T, Open, Close + 1, max(Max, 2 * (Close + 1)));
        true ->
            longest_valid_parentheses(T, 0, 0, Max)
    end.