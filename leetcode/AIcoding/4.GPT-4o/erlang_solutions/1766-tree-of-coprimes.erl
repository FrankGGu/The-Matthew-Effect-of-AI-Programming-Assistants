-module(solution).
-export([getCoprimes/2]).

getCoprimes(Tree, nums) ->
    Tree1 = lists:map(fun({Val, _}) -> Val end, Tree),
    Tree2 = build_tree(Tree),
    lists:map(fun(X) -> find_coprimes(Tree2, nums, X, []) end, Tree1).

build_tree([]) -> #{};
build_tree([{Val, Childs} | T]) ->
    Tree = lists:foldl(fun(Child, Acc) -> maps:put(Child, [], Acc) end, #{Val => Childs}, Childs),
    maps:put(Val, Childs, build_tree(T)).

find_coprimes(Tree, nums, Root, Visited) ->
    case lists:member(Root, Visited) of
        true -> [];
        false -> 
            NewVisited = [Root | Visited],
            Coprimes = lists:filter(fun(X) -> is_coprime(X, Root) end, nums),
            Childs = maps:get(Root, Tree, []),
            lists:concat([Coprimes | lists:map(fun(Child) -> find_coprimes(Tree, nums, Child, NewVisited) end, Childs)])
    end.

is_coprime(A, B) -> gcd(A, B) == 1.

gcd(A, 0) -> A;
gcd(A, B) -> gcd(B, A rem B.