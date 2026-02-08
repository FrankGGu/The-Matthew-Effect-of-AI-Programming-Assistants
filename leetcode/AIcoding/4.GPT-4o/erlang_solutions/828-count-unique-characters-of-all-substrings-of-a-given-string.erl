-module(solution).
-export([unique_chars_count/1]).

unique_chars_count(Str) ->
    Len = length(Str),
    UniqueCount = unique_chars_count_helper(Str, Len, 0, dict:new(), 0),
    UniqueCount.

unique_chars_count_helper(_, 0, Acc, _, Total) ->
    Total;
unique_chars_count_helper(Str, Len, Acc, Seen, Total) ->
    {Char, NewSeen} = dict:store(List_to_binary(substr(Str, Len - 1, 1)), true, Seen),
    NewAcc = if dict:find(Char, Seen) -> Acc + 1; true -> Acc end,
    unique_chars_count_helper(Str, Len - 1, NewAcc, NewSeen, Total + NewAcc).

substr(Str, Start, Length) ->
    lists:sublist(Str, Start + 1, Length).