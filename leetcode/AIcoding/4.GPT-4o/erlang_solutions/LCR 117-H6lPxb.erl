-module(solution).
-export([num_similar_groups/1]).

num_similar_groups(Strs) ->
    N = length(Strs),
    Visited = lists:duplicate(N, false),
    Groups = lists:foldl(fun (Idx, Acc) ->
        if
            lists:nth(Idx + 1, Visited) == false ->
                GroupSize = dfs(Strs, Idx, Visited),
                Acc + 1;
            true ->
                Acc
        end
    end, 0, lists:seq(0, N - 1)),
    Groups.

dfs(Strs, Idx, Visited) ->
    Visited1 = lists:replace_element(Idx + 1, true, Visited),
    lists:foldl(fun (Jdx, Acc) ->
        if
            Jdx =\= Idx andalso is_similar(lists:nth(Idx + 1, Strs), lists:nth(Jdx + 1, Strs)) ->
                dfs(Strs, Jdx, Acc);
            true ->
                Acc
        end
    end, Visited1, lists:seq(0, length(Strs) - 1)).

is_similar(Str1, Str2) ->
    Diff = lists:foldl(fun (C1, {C2, D}) ->
        if
            C1 =:= C2 -> {C2, D};
            true -> {C2, D + 1}
        end
    end, {hd(Str2), 0}, Str1),
    element(2, Diff) =< 2.