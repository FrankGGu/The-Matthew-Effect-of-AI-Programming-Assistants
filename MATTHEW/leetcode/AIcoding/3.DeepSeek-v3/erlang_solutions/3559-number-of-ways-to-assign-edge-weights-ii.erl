-module(solution).
-export([number_of_ways/2]).

number_of_ways(N, Edges) ->
    Tree = build_tree(N, Edges),
    {Count, _} = dfs(1, -1, Tree, #{}),
    Count.

build_tree(N, Edges) ->
    Tree = maps:new(),
    lists:foldl(fun([U, V], Acc) ->
                    maps:update_with(U, fun(List) -> [V | List] end, [V], Acc),
                    maps:update_with(V, fun(List) -> [U | List] end, [U], Acc)
                end, Tree, Edges).

dfs(Node, Parent, Tree, Memo) ->
    case maps:get(Node, Memo, undefined) of
        undefined ->
            Children = [Child || Child <- maps:get(Node, Tree), Child /= Parent],
            {Total, SubMemo} = lists:foldl(fun(Child, {AccCount, AccMemo}) ->
                                                {ChildCount, NewMemo} = dfs(Child, Node, Tree, AccMemo),
                                                {AccCount * ChildCount rem 1000000007, NewMemo}
                                           end, {1, Memo}, Children),
            Fact = factorial(length(Children)),
            Result = (Total * Fact) rem 1000000007,
            {Result, maps:put(Node, Result, SubMemo)};
        Cached ->
            {Cached, Memo}
    end.

factorial(0) -> 1;
factorial(N) -> (N * factorial(N - 1)) rem 1000000007.