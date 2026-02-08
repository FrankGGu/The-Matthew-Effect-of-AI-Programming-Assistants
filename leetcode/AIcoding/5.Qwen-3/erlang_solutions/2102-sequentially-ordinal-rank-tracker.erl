-module(sequential_ordinal_rank_tracker).
-export([new/0, rank/1, unrank/1]).

-record(state, {tree = gb_tree:empty(), size = 0}).

new() ->
    #state{}.

rank(X) ->
    State = erlang:get(?MODULE),
    {Rank, _} = gb_tree:lookup_rank(X, State#state.tree),
    Rank + 1.

unrank(K) ->
    State = erlang:get(?MODULE),
    gb_tree:lookup_key(K - 1, State#state.tree).

gb_tree:insert(X, Tree) ->
    case gb_tree:find(X, Tree) of
        {value, Count} ->
            gb_tree:update(X, Count + 1, Tree);
        none ->
            gb_tree:insert(X, 1, Tree)
    end.

gb_tree:delete(X, Tree) ->
    case gb_tree:find(X, Tree) of
        {value, 1} ->
            gb_tree:delete(X, Tree);
        {value, Count} ->
            gb_tree:update(X, Count - 1, Tree);
        none ->
            Tree
    end.

gb_tree:lookup_rank(X, Tree) ->
    gb_tree:fold(
        fun(Key, Count, {Acc, Total}) ->
            if
                Key < X ->
                    {Acc + Count, Total + Count};
                Key == X ->
                    {Acc + Count, Total + Count};
                true ->
                    {Acc, Total}
            end
        end,
        {0, 0},
        Tree
    ).

gb_tree:lookup_key(Index, Tree) ->
    gb_tree:fold(
        fun(Key, Count, {Acc, Result}) ->
            if
                Acc + Count > Index ->
                    {Index + 1, Key};
                true ->
                    {Acc + Count, Result}
            end
        end,
        {0, undefined},
        Tree
    ).