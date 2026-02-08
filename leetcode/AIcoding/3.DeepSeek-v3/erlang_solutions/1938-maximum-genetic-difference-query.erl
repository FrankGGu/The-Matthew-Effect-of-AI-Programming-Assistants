-module(solution).
-export([max_genetic_difference/3]).

max_genetic_difference(Parents, Queries) ->
    N = length(Parents),
    Root = find_root(Parents),
    Tree = build_tree(Parents),
    Result = lists:map(fun({Node, Val}) -> 
        Path = get_path(Node, Root, Tree, []),
        lists:foldl(fun(X, Max) -> max(Max, X bxor Val) end, 0, Path)
    end, Queries),
    Result.

find_root(Parents) ->
    Children = lists:foldl(fun(P, Acc) ->
        case P of
            -1 -> Acc;
            _ -> maps:put(P, true, Acc)
        end
    end, maps:new(), Parents),
    lists:foldl(fun(I, Root) ->
        case maps:is_key(I - 1, Children) of
            false -> I - 1;
            true -> Root
        end
    end, -1, lists:seq(1, length(Parents))).

build_tree(Parents) ->
    Tree = maps:new(),
    lists:foldl(fun(I, T) ->
        P = lists:nth(I, Parents),
        case P of
            -1 -> T;
            _ -> 
                Children = maps:get(P, T, []),
                maps:put(P, [I - 1 | Children], T)
        end
    end, Tree, lists:seq(1, length(Parents))).

get_path(Node, Root, Tree, Path) ->
    case Node of
        Root -> [Node | Path];
        _ -> 
            Parent = find_parent(Node, Tree),
            get_path(Parent, Root, Tree, [Node | Path])
    end.

find_parent(Node, Tree) ->
    maps:fold(fun(P, Children, Acc) ->
        case lists:member(Node, Children) of
            true -> P;
            false -> Acc
        end
    end, -1, Tree).