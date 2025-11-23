-module(most_stones_removed_with_same_row_or_column).
-export([remove_stones/1]).

remove_stones(Stones) ->
    Rows = maps:new(),
    Cols = maps:new(),
    Parent = maps:new(),
    Rank = maps:new(),
    lists:foreach(fun({R, C}) -> 
        Union(R, C, Parent, Rank)
    end, Stones),
    maps:fold(fun(_K, V, Acc) -> 
        case maps:get(V, Parent, V) of
            V -> Acc + 1;
            _ -> Acc
        end
    end, 0, Parent).

Union(R, C, Parent, Rank) ->
    Key = {R, C},
    if
        maps:is_key(Key, Parent) -> ok;
        true ->
            maps:put(Key, Key, Parent),
            maps:put(Key, 1, Rank)
    end,
    RowKey = {row, R},
    ColKey = {col, C},
    if
        maps:is_key(RowKey, Parent) -> 
            UnionWith(RowKey, Key, Parent, Rank);
        true ->
            maps:put(RowKey, Key, Parent),
            maps:put(RowKey, 1, Rank)
    end,
    if
        maps:is_key(ColKey, Parent) -> 
            UnionWith(ColKey, Key, Parent, Rank);
        true ->
            maps:put(ColKey, Key, Parent),
            maps:put(ColKey, 1, Rank)
    end.

UnionWith(A, B, Parent, Rank) ->
    RootA = Find(A, Parent),
    RootB = Find(B, Parent),
    if
        RootA == RootB -> ok;
        true ->
            if
                maps:get(RootA, Rank) >= maps:get(RootB, Rank) ->
                    maps:put(RootB, RootA, Parent),
                    maps:put(RootA, maps:get(RootA, Rank) + maps:get(RootB, Rank), Rank);
                true ->
                    maps:put(RootA, RootB, Parent),
                    maps:put(RootB, maps:get(RootA, Rank) + maps:get(RootB, Rank), Rank)
            end
    end.

Find(K, Parent) ->
    case maps:get(K, Parent, K) of
        K -> K;
        V -> Find(V, Parent)
    end.