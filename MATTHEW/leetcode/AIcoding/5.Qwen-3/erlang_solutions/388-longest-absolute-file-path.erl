-module(longest_absolute_file_path).
-export([length_longest_path/1]).

length_longest_path(S) ->
    length_longest_path(S, 0, 0, 0, dict:new()).

length_longest_path([], _Depth, _CurrentLength, _MaxLength, _PathMap) ->
    _MaxLength;

length_longest_path([$\n | Rest], Depth, CurrentLength, MaxLength, PathMap) ->
    length_longest_path(Rest, 0, 0, MaxLength, PathMap);

length_longest_path([$\t | Rest], Depth, CurrentLength, MaxLength, PathMap) ->
    length_longest_path(Rest, Depth + 1, CurrentLength, MaxLength, PathMap);

length_longest_path([C | Rest], Depth, CurrentLength, MaxLength, PathMap) ->
    if
        C == $. ->
            NewCurrentLength = CurrentLength + 1,
            NewPathMap = dict:store(Depth, NewCurrentLength, PathMap),
            length_longest_path(Rest, Depth, NewCurrentLength, MaxLength, NewPathMap);
        true ->
            NewCurrentLength = CurrentLength + 1,
            NewPathMap = dict:store(Depth, NewCurrentLength, PathMap),
            length_longest_path(Rest, Depth, NewCurrentLength, MaxLength, NewPathMap)
    end.

length_longest_path([], _Depth, _CurrentLength, MaxLength, _PathMap) ->
    MaxLength.