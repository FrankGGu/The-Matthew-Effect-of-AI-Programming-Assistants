-module(unique_binary_search_trees_ii).
-export([generate_trees/1]).

generate_trees(N) when N == 0 -> [];
generate_trees(N) -> generate_trees(1, N).

generate_trees(Start, End) when Start > End -> [null];
generate_trees(Start, End) ->
    lists:flatmap(fun Root ->
        LeftTrees = generate_trees(Start, Root-1),
        RightTrees = generate_trees(Root+1, End),
        lists:flatmap(fun Left ->
            lists:flatmap(fun Right ->
                [tree(Root, Left, Right)]
            end, RightTrees)
        end, LeftTrees)
    end, lists:seq(Start, End)).

tree(Value, Left, Right) ->
    {value, Value, Left, Right}.