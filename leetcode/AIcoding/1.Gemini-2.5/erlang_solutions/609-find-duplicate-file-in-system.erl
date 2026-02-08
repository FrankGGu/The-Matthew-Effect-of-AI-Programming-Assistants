-module(solution).
-export([findDuplicate/1]).

findDuplicate(Paths) ->
    InitialMap = maps:new(),
    FinalMap = lists:foldl(fun parse_path_string/2, InitialMap, Paths),
    lists:filter(fun(_L) -> length(_L) > 1 end, maps:values(FinalMap)).

parse_path_string(PathString, AccMap) ->
    Parts = string:split(PathString, " ", all),
    [Directory | FileEntries] = Parts,
    lists:foldl(fun(FileEntry, CurrentMap) ->
        parse_file_entry(Directory, FileEntry, CurrentMap)
    end, AccMap, FileEntries).

parse_file_entry(Directory, FileEntry, AccMap) ->
    {ok, Index} = string:find(FileEntry, "("),
    Filename = string:sub_string(FileEntry, 1, Index - 1),
    ContentLength = length(FileEntry) - Index - 1,
    Content = list_to_binary(string:sub_string(FileEntry, Index + 1, ContentLength)),
    FullPath = io_lib:format("~s/~s", [Directory, Filename]),
    maps:update_with(Content, fun(ExistingPaths) -> [FullPath | ExistingPaths] end, [FullPath], AccMap).