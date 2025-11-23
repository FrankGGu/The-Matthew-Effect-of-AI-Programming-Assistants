-module(solution).
-export([minimum_beautiful_changes/1]).

minimum_beautiful_changes(BinaryString) ->
    Length = string:length(BinaryString),
    Changes = calculate_changes(BinaryString, Length, 0, 0),
    Changes.

calculate_changes([], _, CurrentChanges, _) -> 
    CurrentChanges;
calculate_changes([H | T], Length, CurrentChanges, Last) ->
    NewChanges = if 
        H =:= $0 andalso Last =:= $0 -> CurrentChanges + 1;
        H =:= $1 andalso Last =:= $1 -> CurrentChanges + 1;
        true -> CurrentChanges
    end,
    calculate_changes(T, Length, NewChanges, H).