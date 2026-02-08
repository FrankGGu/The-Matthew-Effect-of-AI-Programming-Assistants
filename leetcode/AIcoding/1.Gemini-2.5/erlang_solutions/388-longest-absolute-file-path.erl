-module(solution).
-export([longest_absolute_path/1]).

longest_absolute_path(Input) ->
    Entries = string:tokens(Input, "\n"),
    {MaxLen, _} = lists:foldl(fun process_entry/2, {0, []}, Entries),
    MaxLen.

process_entry(Entry, {MaxLen, PathLengths}) ->
    {Depth, Name} = get_depth_and_name(Entry),

    ParentPathLength = 
        if Depth == 0 -> 0;
           true -> lists:nth(Depth, PathLengths)
        end,

    CurrentEntryLength = ParentPathLength + length(Name),

    ActualCurrentEntryLength = 
        if Depth > 0 -> CurrentEntryLength + 1; % Add 1 for '/' separator
           true -> CurrentEntryLength
        end,

    NewPathLengths = lists:sublist(PathLengths, Depth) ++ [ActualCurrentEntryLength],

    NewMaxLen = 
        if string:str(Name, ".") > 0 -> % It's a file if it contains '.'
               max(MaxLen, ActualCurrentEntryLength);
           true -> MaxLen
        end,

    {NewMaxLen, NewPathLengths}.

get_depth_and_name(Entry) ->
    get_depth_and_name(Entry, 0).

get_depth_and_name([$\t | T], Depth) ->
    get_depth_and_name(T, Depth + 1);
get_depth_and_name(Name, Depth) ->
    {Depth, Name}.