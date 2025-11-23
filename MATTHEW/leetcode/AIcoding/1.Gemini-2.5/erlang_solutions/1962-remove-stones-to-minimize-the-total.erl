-module(solution).
-export([min_stones/2]).

min_stones(Piles, K) ->
    InitialTree = lists:foldl(
        fun(Pile, AccTree) ->
            gb_trees:insert({Pile, make_ref()}, nil, AccTree)
        end,
        gb_trees:empty(),
        Piles
    ),
    FinalTree = perform_operations(K, InitialTree),
    Sum = lists:foldl(
        fun({Key, _Value}, AccSum) ->
            element(1, Key) + AccSum
        end,
        0,
        gb_trees:to_list(FinalTree)
    ),
    Sum.

perform_operations(0, Tree) ->
    Tree;
perform_operations(K, Tree) ->
    case gb_trees:is_empty(Tree) of
        true ->
            Tree;
        false ->
            {{MaxPile, _Ref}, _Value, TreeWithoutMax} = gb_trees:take_max(Tree),
            NewPile = MaxPile - trunc(MaxPile / 2),
            NewTree = gb_trees:insert({NewPile, make_ref()}, nil, TreeWithoutMax),
            perform_operations(K - 1, NewTree)
    end.