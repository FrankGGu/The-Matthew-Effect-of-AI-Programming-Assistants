-module(solution).
-export([find_duplicate/1]).

find_duplicate(Filenames) ->
    find_duplicate(Filenames, dict:new()).

find_duplicate([], _) ->
    undefined;
find_duplicate([File | Rest], Dict) ->
    case dict:is_key(File, Dict) of
        true ->
            File;
        false ->
            find_duplicate(Rest, dict:store(File, true, Dict))
    end.