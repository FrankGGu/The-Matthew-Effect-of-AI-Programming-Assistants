-module(solution).
-export([str_distinct/1]).

str_distinct(Strs) ->
    Groups = lists:foldl(fun(Str, Acc) -> add_to_group(Str, Acc) end, [], Strs),
    length(Groups).

add_to_group(Str, []) ->
    [[Str]];
add_to_group(Str, [Group | Rest]) ->
    case is_similar(Str, Group) of
        true -> [lists:append(Group, [Str]) | Rest];
        false -> [Group | add_to_group(Str, Rest)]
    end.

is_similar(A, B) ->
    Diff = lists:foldl(fun({C1, C2}, Acc) -> if C1 /= C2 -> Acc + 1; true -> Acc end end, 0, lists:zip(A, B)),
    Diff =< 2.