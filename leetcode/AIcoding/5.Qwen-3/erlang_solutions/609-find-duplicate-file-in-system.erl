-module(find_duplicate_file_in_system).
-export([find_duplicates/1]).

find_duplicates(Files) ->
    Maps = lists:foldl(fun(File, Acc) ->
        [Dir | Names] = string:split(File, " "),
        lists:foldl(fun(Name, Acc2) ->
            Key = filename:basename(Name),
            Path = Dir ++ "/" ++ Name,
            case maps:is_key(Key, Acc2) of
                true ->
                    maps:update(Key, [Path | maps:get(Key, Acc2)], Acc2);
                false ->
                    maps:put(Key, [Path], Acc2)
            end
        end, Acc, Names)
    end, maps:new(), Files),
    lists:filter(fun({_Key, Paths}) -> length(Paths) > 1 end, maps:to_list(Maps)),
    lists:map(fun({_Key, Paths}) -> Paths end, lists:filter(fun({_Key, Paths}) -> length(Paths) > 1 end, maps:to_list(Maps))).