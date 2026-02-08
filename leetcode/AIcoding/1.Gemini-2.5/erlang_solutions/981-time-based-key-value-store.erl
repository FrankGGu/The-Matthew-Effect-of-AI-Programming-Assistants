-module(time_map).
-export([new/0, set/4, get/3]).

-record(state, {store = #{} :: #{binary() => gb_trees:tree()}}).

new() ->
    #state{}.

set(State, Key, Value, Timestamp) ->
    #state{store = Store} = State,
    Tree = maps:get(Key, Store, gb_trees:empty()),
    NewTree = gb_trees:insert(Timestamp, Value, Tree),
    NewStore = maps:put(Key, NewTree, Store),
    State#state{store = NewStore}.

get(State, Key, Timestamp) ->
    #state{store = Store} = State,
    case maps:find(Key, Store) of
        {ok, Tree} ->
            find_value_gb_tree(Tree, Timestamp);
        _ ->
            ""
    end.

find_value_gb_tree(Tree, TargetTs) ->
    ItGE = gb_trees:iterator(TargetTs, Tree),
    case gb_trees:next(ItGE) of
        {K, V, _} ->
            if K == TargetTs ->
                V;
            true ->
                ItPrev = gb_trees:iterator(K, Tree),
                case gb_trees:prev(ItPrev) of
                    {_PrevK, PrevV, _} -> PrevV;
                    none -> ""
                end
            end;
        none ->
            case gb_trees:iterator_from_max(Tree) of
                {_MaxK, MaxV, _} -> MaxV;
                _ -> ""
            end
    end.