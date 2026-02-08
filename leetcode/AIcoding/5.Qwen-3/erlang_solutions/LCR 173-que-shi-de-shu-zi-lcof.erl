-module(solution).
-export([find_name/1]).

find_name(Names) ->
    find_name(Names, 0).

find_name([], _) ->
    -1;
find_name([Name | Rest], Index) ->
    case lists:member(Name, Rest) of
        true ->
            find_name(Rest, Index + 1);
        false ->
            Index
    end.