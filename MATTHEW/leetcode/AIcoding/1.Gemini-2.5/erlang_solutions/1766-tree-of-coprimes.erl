-module(solution).
-export([get_coprimes/2]).

gcd(A, 0) -> A;
gcd(A, B) -> gcd(B, A rem B).

get_coprimes(Nums, Edges) ->
    N = length(Nums),
    NumsArr = array:from_list(Nums),
    Adj = build_adj(N, Edges),
    Results = array:new([{size, N}, {default, -1}]),
    PathInfo = array:new([{size, 51}, {default, {nil, -1}}]),
    dfs(0, -1, 0, Adj, NumsArr, PathInfo, Results).

dfs(Node, Parent, Depth, Adj, NumsArr, PathInfo, Results) ->
    CurrentVal = array:get(Node, NumsArr),
    {FoundAncestorNode, _FoundMaxDepth} = find_coprime_ancestor_helper(1, CurrentVal, PathInfo, -1, -1),
    NewResults = array:set(Node, FoundAncestorNode, Results),
    UpdatedPathInfo = array:set(CurrentVal, {Node, Depth}, PathInfo),
    Children = array:get(Node, Adj),
    lists:foldl(fun(Child, AccResults) ->
                    if Child == Parent ->
                        AccResults;
                    true ->
                        dfs(Child, Node, Depth + 1, Adj, NumsArr, UpdatedPathInfo, AccResults)
                    end
                end, NewResults, Children).

find_coprime_ancestor_helper(ValToCheck, CurrentNodeVal, PathInfo, AccAncestorNode, AccMaxDepth) ->
    if ValToCheck > 50 ->
        {AccAncestorNode, AccMaxDepth};
    true ->
        case gcd(CurrentNodeVal, ValToCheck) of
            1 ->
                {AncestorNode, AncestorDepth} = array:get(ValToCheck, PathInfo),
                if AncestorDepth > AccMaxDepth ->
                    find_coprime_ancestor_helper(ValToCheck + 1, CurrentNodeVal, PathInfo, AncestorNode, AncestorDepth);
                true ->
                    find_coprime_ancestor_helper(ValToCheck + 1, CurrentNodeVal, PathInfo, AccAncestorNode, AccMaxDepth)
                end;
            _ ->
                find_coprime_ancestor_helper(ValToCheck + 1, CurrentNodeVal, PathInfo, AccAncestorNode, AccMaxDepth)
        end
    end.

build_adj(N, Edges) ->
    Adj = array:new([{size, N}, {default, []}]),
    lists:foldl(fun([U, V], AccAdj) ->
                    AccAdj1 = array:set(U, [V | array:get(U, AccAdj)], AccAdj),
                    array:set(V, [U | array:get(V, AccAdj)], AccAdj1)
                end, Adj, Edges).