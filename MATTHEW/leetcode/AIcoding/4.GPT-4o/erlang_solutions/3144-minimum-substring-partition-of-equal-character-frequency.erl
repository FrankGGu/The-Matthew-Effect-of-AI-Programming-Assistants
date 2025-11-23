-module(solution).
-export([min_substring_partition/1]).

min_substring_partition(Str) ->
    Length = length(Str),
    min_partition(Str, 0, Length, #{}, Length).

min_partition(_, Start, End, Counts, MinLength) when Start >= End ->
    if map_size(Counts) == 0 -> 
        MinLength; 
    true -> 
        MinLength
    end;
min_partition(Str, Start, End, Counts, MinLength) ->
    Char = string:substr(Str, Start + 1, 1),
    NewCounts = maps:update_with(Char, fun(X) -> X + 1 end, 1, Counts),
    NewMinLength = if length(NewCounts) == 1 -> 
        min(MinLength, Start + 1 - 0); 
    true -> 
        MinLength 
    end,
    min_partition(Str, Start + 1, End, NewCounts, NewMinLength).

min(A, B) when A < B -> A;
min(_, B) -> B.