-module(minimum_number_of_frogs_croaking).
-export([croak/1]).

croak(S) ->
    Map = maps:from_list([{$c, 0}, {$r, 0}, {$o, 0}, {$a, 0}, {$k, 0}]),
    count(S, Map, 0).

count([], _, _) -> 0;
count([$c|T], Map, Count) ->
    NewMap = maps:update($c, maps:get($c, Map) + 1, Map),
    count(T, NewMap, Count);
count([$r|T], Map, Count) ->
    case maps:get($c, Map) > 0 of
        true ->
            NewMap = maps:update($c, maps:get($c, Map) - 1, Map),
            NewMap2 = maps:update($r, maps:get($r, Map) + 1, NewMap),
            count(T, NewMap2, Count);
        false ->
            -1
    end;
count([$o|T], Map, Count) ->
    case maps:get($r, Map) > 0 of
        true ->
            NewMap = maps:update($r, maps:get($r, Map) - 1, Map),
            NewMap2 = maps:update($o, maps:get($o, Map) + 1, NewMap),
            count(T, NewMap2, Count);
        false ->
            -1
    end;
count([$a|T], Map, Count) ->
    case maps:get($o, Map) > 0 of
        true ->
            NewMap = maps:update($o, maps:get($o, Map) - 1, Map),
            NewMap2 = maps:update($a, maps:get($a, Map) + 1, NewMap),
            count(T, NewMap2, Count);
        false ->
            -1
    end;
count([$k|T], Map, Count) ->
    case maps:get($a, Map) > 0 of
        true ->
            NewMap = maps:update($a, maps:get($a, Map) - 1, Map),
            NewMap2 = maps:update($k, maps:get($k, Map) + 1, NewMap),
            count(T, NewMap2, Count + 1);
        false ->
            -1
    end;
count([_|_], _, _) -> -1.