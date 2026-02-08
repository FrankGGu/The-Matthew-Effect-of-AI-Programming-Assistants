-module(pyramid_transition).
-export([pyramidTransition/2]).

pyramidTransition(Bottom, Allowed) ->
    allowed_map(Allowed, Map),
    pyramidTransition(Bottom, Map).

pyramidTransition(Bottom, Map) ->
    Len = length(Bottom),
    if Len == 1 ->
        true;
    true ->
        NextBottom = next_bottom(Bottom),
        pyramidTransition(NextBottom, Map)
    end.

next_bottom(Bottom) ->
    next_bottom(Bottom, []).

next_bottom([_], Acc) ->
    lists:reverse(Acc);
next_bottom([A, B | Rest], Acc) ->
    case possible_chars(A, B, Map) of
        [] ->
            false;
        Chars ->
            lists:any(fun(C) ->
                next_bottom([B | Rest], [C | Acc])
            end, Chars)
    end.

possible_chars(A, B, Map) ->
    case maps:get({A, B}, Map, []) of
        [] ->
            [];
        Chars ->
            Chars
    end.

allowed_map(Allowed) ->
    allowed_map(Allowed, #{}).

allowed_map([], Map) ->
    Map;
allowed_map([<<A:8,B:8,C:8>> | Rest], Map) ->
    Key = {A, B},
    Chars = maps:get(Key, Map, []),
    NewMap = maps:put(Key, [C | Chars], Map),
    allowed_map(Rest, NewMap).