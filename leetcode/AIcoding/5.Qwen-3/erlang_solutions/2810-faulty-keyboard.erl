-module(faulty_keyboard).
-export([find_string/1]).

find_string(Keys) ->
    find_string(Keys, []).

find_string([], Acc) ->
    lists:reverse(Acc);
find_string([$B | T], Acc) ->
    find_string(T, Acc);
find_string([C | T], Acc) ->
    find_string(T, [C | Acc]).