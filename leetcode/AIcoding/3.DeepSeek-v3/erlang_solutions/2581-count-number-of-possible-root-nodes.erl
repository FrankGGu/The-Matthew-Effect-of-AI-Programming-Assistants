-module(solution).
-export([root_count/3]).

root_count(Edges, Guesses, K) ->
    N = length(Edges) + 1,
    Tree = build_tree(Edges),
    GuessSet = sets:from_list(Guesses),
    Root0 = 0,
    Count0 = count_guesses(Root0, -1, Tree, GuessSet),
    dfs(Root0, -1, Count0, K, Tree, GuessSet, 0).

build_tree(Edges) ->
    Tree = maps:new(),
    lists:foldl(fun([U, V], Acc) ->
        Acc1 = maps:update_with(U, fun(L) -> [V | L] end, [V], Acc),
        maps:update_with(V, fun(L) -> [U | L] end, [U], Acc1)
    end, Tree, Edges).

count_guesses(Node, Parent, Tree, GuessSet) ->
    Children = maps:get(Node, Tree, []),
    lists:foldl(fun(Child, Acc) ->
        case Child =:= Parent of
            true -> Acc;
            false ->
                case sets:is_element({Node, Child}, GuessSet) of
                    true -> Acc + 1 + count_guesses(Child, Node, Tree, GuessSet);
                    false -> Acc + count_guesses(Child, Node, Tree, GuessSet)
                end
        end
    end, 0, Children).

dfs(Node, Parent, Count, K, Tree, GuessSet, Result) ->
    NewResult = case Count >= K of
        true -> Result + 1;
        false -> Result
    end,
    Children = maps:get(Node, Tree, []),
    lists:foldl(fun(Child, Acc) ->
        case Child =:= Parent of
            true -> Acc;
            false ->
                NewCount = case sets:is_element({Node, Child}, GuessSet) of
                    true -> Count - 1;
                    false -> Count
                end,
                NewCount1 = case sets:is_element({Child, Node}, GuessSet) of
                    true -> NewCount + 1;
                    false -> NewCount
                end,
                dfs(Child, Node, NewCount1, K, Tree, GuessSet, Acc)
        end
    end, NewResult, Children).