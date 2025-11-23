-module(solution).
-export([close_strings/2]).

close_strings(A, B) ->
    case erlang:length(A) == erlang:length(B) of
        false -> false;
        true ->
            MapA = count_chars(A),
            MapB = count_chars(B),
            ValuesA = lists:sort(lists:values(MapA)),
            ValuesB = lists:sort(lists:values(MapB)),
            KeysA = lists:sort(lists:keys(MapA)),
            KeysB = lists:sort(lists:keys(MapB)),
            ValuesA == ValuesB andalso KeysA == KeysB
    end.

count_chars(Str) ->
    count_chars(Str, #{}).

count_chars([], Acc) ->
    Acc;
count_chars([C | Rest], Acc) ->
    Count = maps:get(C, Acc, 0),
    count_chars(Rest, maps:put(C, Count + 1, Acc)).