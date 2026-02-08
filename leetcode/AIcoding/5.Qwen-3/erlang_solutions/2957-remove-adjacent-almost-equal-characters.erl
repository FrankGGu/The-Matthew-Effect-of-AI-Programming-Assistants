-module(remove_adjacent_almost_equal_characters).
-export([remove_almost_equal/1]).

remove_almost_equal(Str) ->
    remove_almost_equal(Str, []).

remove_almost_equal([], Acc) ->
    lists:reverse(Acc);
remove_almost_equal([C | Rest], []) ->
    remove_almost_equal(Rest, [C]);
remove_almost_equal([C | Rest], [Prev | Acc]) ->
    if
        abs(C - Prev) =< 1 ->
            remove_almost_equal(Rest, Acc);
        true ->
            remove_almost_equal(Rest, [C | [Prev | Acc]])
    end.