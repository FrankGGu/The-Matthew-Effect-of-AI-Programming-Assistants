-module(largest_substring_between_two_equal_characters).
-export([max_length/1]).

max_length(Str) ->
    max_length(Str, 0, 0, dict:new()).

max_length([], Max, _LastIndex, _Dict) ->
    Max;
max_length([C | T], Max, LastIndex, Dict) ->
    case dict:is_key(C, Dict) of
        true ->
            Index = dict:fetch(C, Dict),
            NewMax = if Index < LastIndex -> Max; true -> erlang:max(Max, LastIndex - Index - 1) end,
            max_length(T, NewMax, LastIndex + 1, dict:store(C, LastIndex, Dict));
        false ->
            max_length(T, Max, LastIndex + 1, dict:store(C, LastIndex, Dict))
    end.