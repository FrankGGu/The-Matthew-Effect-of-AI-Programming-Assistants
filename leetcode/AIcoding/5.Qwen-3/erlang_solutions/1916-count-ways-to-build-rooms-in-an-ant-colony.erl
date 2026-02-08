-module(solution).
-export([ways_to_build_rooms/1]).

ways_to_build_rooms(Relations) ->
    {Tree, Root} = build_tree(Relations),
    {_, Result} = dfs(Tree, Root, 1, 1, dict:new()),
    Result.

build_tree(Relations) ->
    Tree = dict:new(),
    lists:foreach(fun({Parent, Child}) ->
        case dict:is_key(Parent, Tree) of
            true -> dict:store(Parent, [Child | dict:fetch(Parent, Tree)], Tree);
            false -> dict:store(Parent, [Child], Tree)
        end
    end, Relations),
    Root = find_root(Relations),
    {Tree, Root}.

find_root(Relations) ->
    Parents = lists:foldl(fun({P, _}, Acc) -> [P | Acc] end, [], Relations),
    Children = lists:foldl(fun({_, C}, Acc) -> [C | Acc] end, [], Relations),
    lists:hd(lists:subtract(Parents, Children)).

dfs(Tree, Node, Factor, Result, Memo) ->
    case dict:is_key(Node, Memo) of
        true -> {Factor, Result};
        false ->
            Children = dict:fetch(Node, Tree, []),
            Total = 1,
            Fact = factorial(length(Children)),
            {NewFactor, NewResult} = lists:foldl(
                fun(Child, {AccFactor, AccResult}) ->
                    {ChildFactor, ChildResult} = dfs(Tree, Child, 1, 0, Memo),
                    {AccFactor * ChildFactor, AccResult + ChildResult}
                end,
                {1, 0},
                Children
            ),
            NewMemo = dict:store(Node, NewFactor, Memo),
            {NewFactor * Fact, (NewResult + 1) * NewFactor}
    end.

factorial(N) when N == 0 -> 1;
factorial(N) -> N * factorial(N - 1).