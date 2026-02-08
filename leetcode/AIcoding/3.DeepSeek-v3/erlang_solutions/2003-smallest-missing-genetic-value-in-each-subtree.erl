-module(solution).
-export([smallest_missing_value_subtree/2]).

smallest_missing_value_subtree(Parents, Nums) ->
    N = length(Parents),
    Children = build_children(Parents),
    Result = array:new(N, {default, 1}),
    {Result1, _} = dfs(0, Children, Nums, Result, sets:new()),
    array:to_list(Result1).

build_children(Parents) ->
    lists:foldl(fun(I, Acc) ->
        P = lists:nth(I + 1, Parents),
        case P of
            -1 -> Acc;
            _ -> 
                Current = maps:get(P, Acc, []),
                maps:put(P, [I | Current], Acc)
        end
    end, maps:new(), lists:seq(0, length(Parents) - 1)).

dfs(Node, Children, Nums, Result, Visited) ->
    ChildrenList = maps:get(Node, Children, []),
    {Result1, Visited1} = lists:foldl(fun(Child, {ResAcc, VisAcc}) ->
        {Res, Vis} = dfs(Child, Children, Nums, ResAcc, VisAcc),
        {Res, Vis}
    end, {Result, Visited}, ChildrenList),
    Num = lists:nth(Node + 1, Nums),
    Visited2 = sets:add_element(Num, Visited1),
    Missing = find_missing(Visited2, 1),
    Result2 = array:set(Node, Missing, Result1),
    {Result2, Visited2}.

find_missing(Set, X) ->
    case sets:is_element(X, Set) of
        true -> find_missing(Set, X + 1);
        false -> X
    end.