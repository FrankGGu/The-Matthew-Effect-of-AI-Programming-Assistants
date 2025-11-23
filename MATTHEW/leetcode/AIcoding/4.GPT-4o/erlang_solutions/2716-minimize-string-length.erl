-module(solution).
-export([minimize_string_length/1]).

minimize_string_length(Str) ->
    UniqueChars = lists:usort(lists:foldl(fun (C, Acc) -> [C | Acc] end, [], Str)),
    length(UniqueChars).