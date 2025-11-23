-module(min_add_to_make_parentheses_valid).
-export([min_addToMakeValid/1]).

min_addToMakeValid(S) ->
    min_add_to_make_valid(S, 0, 0).

min_add_to_make_valid([], Open, Close) ->
    Open + Close;
min_add_to_make_valid([$() | T], Open, Close) ->
    min_add_to_make_valid(T, Open + 1, Close);
min_add_to_make_valid([$)] | T], Open, Close) ->
    if
        Open > 0 ->
            min_add_to_make_valid(T, Open - 1, Close);
        true ->
            min_add_to_make_valid(T, Open, Close + 1)
    end.