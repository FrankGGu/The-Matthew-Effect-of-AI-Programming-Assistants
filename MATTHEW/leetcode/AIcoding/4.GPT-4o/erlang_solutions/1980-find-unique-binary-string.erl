-module(solution).
-export([find_unique_binary_string/1]).

find_unique_binary_string(N) ->
    UniqueString = lists:duplicate(N, $0),
    find_unique_binary_string(UniqueString, [], N).

find_unique_binary_string(UniqueString, Acc, 0) ->
    lists:reverse(Acc);
find_unique_binary_string(UniqueString, Acc, N) ->
    NewChar = if lists:nth(N, UniqueString) =:= $0 -> $1; 
                true -> $0 end,
    find_unique_binary_string(UniqueString, [NewChar | Acc], N - 1).