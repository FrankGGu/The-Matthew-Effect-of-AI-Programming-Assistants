-module(min_remove_to_make_valid_parentheses).
-export([min_remove_to_make_valid_parentheses/1]).

min_remove_to_make_valid_parentheses(S) ->
    {Valid, _} = process(S, 0, []),
    Valid.

process([], _, Acc) ->
    lists:reverse(Acc);
process([$( | Rest], Count, Acc) ->
    process(Rest, Count + 1, [$( | Acc]);
process([$) | Rest], Count, Acc) ->
    if
        Count > 0 ->
            process(Rest, Count - 1, [$) | Acc]);
        true ->
            process(Rest, Count, Acc)
    end;
process([C | Rest], Count, Acc) ->
    process(Rest, Count, [C | Acc]).