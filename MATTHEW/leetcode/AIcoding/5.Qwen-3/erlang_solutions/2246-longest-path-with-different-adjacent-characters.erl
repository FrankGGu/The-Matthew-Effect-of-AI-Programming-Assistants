-module(longest_path_with_different_adjacent_characters).
-export([longest_path/1]).

longest_path(Root) ->
    {MaxLen, _} = dfs(Root, -1),
    MaxLen.

dfs(Node, Parent) ->
    Children = get_children(Node),
    Max1 = 0,
    Max2 = 0,
    for_each_child(Children, Node, Parent, Max1, Max2, fun(Val, _, _) -> Val end).

for_each_child([], _, _, Max1, Max2, Fun) ->
    Fun(max(Max1, Max2), 0);
for_each_child([Child | Rest], Current, Parent, Max1, Max2, Fun) ->
    case Child of
        {_, Char} when Char /= get_char(Current) ->
            {Len, _} = dfs(Child, Current),
            if Len > Max1 ->
                for_each_child(Rest, Current, Parent, Len, Max1, Fun);
            Len > Max2 ->
                for_each_child(Rest, Current, Parent, Max1, Len, Fun);
            true ->
                for_each_child(Rest, Current, Parent, Max1, Max2, Fun)
            end;
        _ ->
            for_each_child(Rest, Current, Parent, Max1, Max2, Fun)
    end.

get_children({_, _, Children}) ->
    Children;
get_children(_) ->
    [].

get_char({Char, _, _}) ->
    Char;
get_char(_) ->
    $.

max(A, B) when A >= B ->
    A;
max(_, B) ->
    B.