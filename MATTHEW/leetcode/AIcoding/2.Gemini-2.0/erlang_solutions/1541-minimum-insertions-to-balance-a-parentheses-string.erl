-module(minimum_insertions).
-export([min_insertions/1]).

min_insertions(S) ->
    min_insertions(S, 0, 0).

min_insertions([], Open, Need) ->
    Open * 2 + Need;
min_insertions([$( | Rest], Open, Need) ->
    min_insertions(Rest, Open + 1, Need);
min_insertions([$) | Rest], Open, Need) ->
    case Open > 0 of
        true ->
            min_insertions(Rest, Open - 1, Need + 1);
        false ->
            min_insertions(Rest, 0, Need + 2);
        end.