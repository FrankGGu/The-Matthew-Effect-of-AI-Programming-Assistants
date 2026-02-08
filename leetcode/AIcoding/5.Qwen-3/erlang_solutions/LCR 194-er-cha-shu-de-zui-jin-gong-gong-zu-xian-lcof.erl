-module(solve).
-export([lowest_common_ancestor/3]).

-record(tree, {val, left, right}).

lowest_common_ancestor(Val, Val1, Val2) ->
    lowest_common_ancestor(build_tree(Val), Val1, Val2).

build_tree([]) -> nil;
build_tree([Val | Rest]) ->
    {tree, Val, build_tree(lists:nth(1, Rest)), build_tree(lists:nth(2, Rest))}.

lowest_common_ancestor(nil, _, _) -> nil;
lowest_common_ancestor(Node, Val1, Val2) ->
    case find_path(Node, Val1) of
        false -> nil;
        Path1 ->
            case find_path(Node, Val2) of
                false -> nil;
                Path2 ->
                    get_lca(Path1, Path2)
            end
    end.

find_path(nil, _) -> false;
find_path(Node, Val) ->
    find_path(Node, Val, []).

find_path(Node, Val, Path) ->
    case Node of
        {tree, Val, _, _} -> [Node | Path];
        _ ->
            Left = case Node of
                       {tree, _, L, _} -> L;
                       _ -> nil
                   end,
            case find_path(Left, Val, [Node | Path]) of
                false -> 
                    Right = case Node of
                                {tree, _, _, R} -> R;
                                _ -> nil
                            end,
                    find_path(Right, Val, [Node | Path]);
                P -> P
            end
    end.

get_lca([], _) -> nil;
get_lca(_, []) -> nil;
get_lca([A | _], [A | _]) -> A;
get_lca([A | T1], [B | T2]) ->
    if A == B -> A;
       true -> get_lca(T1, T2)
    end.