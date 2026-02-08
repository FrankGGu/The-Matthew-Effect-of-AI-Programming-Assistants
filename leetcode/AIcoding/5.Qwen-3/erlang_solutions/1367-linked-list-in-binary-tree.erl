-module(solution).
-export([is_sub_path/2]).

is_sub_path(Head, Root) ->
    is_sub_path(Head, Root, []).

is_sub_path(_, _, _) -> false;
is_sub_path(Head, Root, Path) ->
    case lists:member(Root, Path) of
        true -> false;
        false ->
            NewPath = [Root | Path],
            case is_linked_list(Head, Root) of
                true -> true;
                false -> 
                    Left = case Root#tree.left of
                               nil -> false;
                               _ -> is_sub_path(Head, Root#tree.left, NewPath)
                           end,
                    Right = case Root#tree.right of
                                nil -> false;
                                _ -> is_sub_path(Head, Root#tree.right, NewPath)
                            end,
                    Left orelse Right
            end
    end.

is_linked_list(nil, _) -> true;
is_linked_list(Head, Root) ->
    case Head of
        nil -> true;
        _ ->
            case Head#list.val == Root#tree.val of
                true ->
                    is_linked_list(Head#list.next, Root);
                false -> false
            end
    end.

-record(list, {val, next}).
-record(tree, {val, left, right}).