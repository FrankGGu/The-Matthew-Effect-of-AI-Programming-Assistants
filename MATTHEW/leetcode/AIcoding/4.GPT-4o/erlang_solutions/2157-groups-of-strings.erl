-module(solution).
-export([num_groups/1]).

num_groups(Strs) ->
    Groups = lists:map(fun(S) -> group(S) end, Strs),
    UniqueGroups = lists:usort(Groups),
    length(UniqueGroups).

group(S) ->
    Chars = string:to_list(S),
    MinChar = lists:min(Chars),
    Shifted = lists:map(fun(C) -> (C - MinChar) rem 26 end, Chars),
    lists:sort(Shifted).