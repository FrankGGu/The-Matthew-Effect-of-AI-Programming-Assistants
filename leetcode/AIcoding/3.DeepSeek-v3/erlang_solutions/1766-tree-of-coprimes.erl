-module(solution).
-export([get_coprimes/2]).

get_coprimes(Nums, Edges) ->
    Adj = build_adj(Nums, Edges),
    Ans = array:new(Nums, {default, -1}),
    Path = array:new(51, {default, []}),
    dfs(0, -1, 0, Nums, Adj, Path, Ans).

build_adj(Nums, Edges) ->
    Adj = array:new(Nums, {default, []}),
    lists:foldl(fun([U, V], Acc) ->
                    A1 = array:set(U, [V | array:get(U, Acc)], Acc),
                    array:set(V, [U | array:get(V, A1)], A1)
                end, Adj, Edges).

dfs(Node, Parent, Depth, Nums, Adj, Path, Ans) ->
    Num = lists:nth(Node + 1, Nums),
    Coprimes = find_coprimes(Num, Path),
    Ans1 = case Coprimes of
               [] -> Ans;
               _ ->
                   {MaxDepth, Val} = lists:max(lists:map(fun({D, V}) -> {D, V} end, Coprimes)),
                   array:set(Node, Val, Ans)
           end,
    Path1 = array:set(Num, [{Depth, Node} | array:get(Num, Path)], Path),
    Children = lists:filter(fun(Child) -> Child =/= Parent end, array:get(Node, Adj)),
    lists:foldl(fun(Child, {A, P}) ->
                    dfs(Child, Node, Depth + 1, Nums, Adj, P, A)
                end, {Ans1, Path1}, Children),
    Ans1.

find_coprimes(Num, Path) ->
    lists:flatten([array:get(X, Path) || X <- lists:seq(1, 50), gcd(X, Num) =:= 1]).

gcd(A, 0) -> A;
gcd(A, B) -> gcd(B, A rem B).