-module(solution).
-export([num_similar_groups/1]).

num_similar_groups(Strs) ->
    Groups = lists:foldl(fun(Str, Acc) -> add_to_group(Str, Acc) end, [], Strs),
    length(Groups).

add_to_group(Str, []) -> [[Str]];
add_to_group(Str, [Group | Rest]) ->
    if
        similar(Str, hd(Group)) -> [[Str | Group] | Rest];
        true -> [Group | add_to_group(Str, Rest)]
    end.

similar(Str1, Str2) ->
    Diff = lists:filter(fun({C1, C2}) -> C1 /= C2 end,
        lists:zip(list_to_tuple(Str1), list_to_tuple(Str2))),
    case length(Diff) of
        0 -> true;
        2 -> let 
                [{C1, C2}, {C3, C4}] = Diff 
              in
                C1 =:= C4 andalso C2 =:= C3
              end;
        _ -> false
    end.