-module(contains_duplicate_iii).
-export([contains_nearby_almost_duplicate/3]).

contains_nearby_almost_duplicate(Nums, K, T) ->
    contains_nearby_almost_duplicate(Nums, K, T, gb_trees:empty()).

contains_nearby_almost_duplicate([], _K, _T, _Tree) ->
    false;
contains_nearby_almost_duplicate([H|Tail], K, T, Tree) ->
    case find_nearby(H, T, Tree) of
        true ->
            true;
        false ->
            NewTree = gb_trees:insert(H, H, Tree),
            case length(Tail) < K of
                true ->
                    contains_nearby_almost_duplicate(Tail, K, T, NewTree);
                false ->
                    ToRemove = lists:nth(K + 1, [H|Tail]),
                    NewTree2 = gb_trees:delete(ToRemove, NewTree),
                    contains_nearby_almost_duplicate(Tail, K, T, NewTree2)
            end
    end.

find_nearby(H, T, Tree) ->
    LowerBound = H - T,
    UpperBound = H + T,
    SubTree = gb_trees:take_smallest(Tree, fun(Key, _Value) -> Key >= LowerBound end),
    case SubTree of
        {_, Tree2} ->
            case gb_trees:smallest(Tree2) of
                {Key, _} when Key =< UpperBound ->
                    true;
                _ ->
                    false
            end;
        _->
            false
    end.