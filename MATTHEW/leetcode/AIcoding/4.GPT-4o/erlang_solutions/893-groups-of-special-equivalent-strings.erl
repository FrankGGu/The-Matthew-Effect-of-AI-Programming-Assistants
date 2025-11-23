-module(solution).
-export([num_special_equiv_groups/1]).

num_special_equiv_groups(Strs) ->
    Strs1 = lists:map(fun(S) -> special_equiv_key(S) end, Strs),
    Strs2 = lists:usort(Strs1),
    length(Strs2).

special_equiv_key(Str) ->
    {lists:sort(lists:filter(fun(C) -> (C rem 2) == 1 end, lists:map(fun(C) -> (C - $a) rem 2 end, string:to_list(Str))),
    lists:sort(lists:filter(fun(C) -> (C rem 2) == 0 end, lists:map(fun(C) -> (C - $a) rem 2 end, string:to_list(Str))) }.