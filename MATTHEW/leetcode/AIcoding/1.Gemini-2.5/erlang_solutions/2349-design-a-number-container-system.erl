-module(number_container).
-export([new/0, change/3, find/2]).

new() ->
    #{index_to_num => #{},
      num_to_indices => #{}
     }.

change(State, Index, Number) ->
    IndexToNumMap = maps:get(index_to_num, State),
    NumToIndicesMap = maps:get(num_to_indices, State),

    {_OldNumber, NewNumToIndicesMap1} =
        case maps:find(Index, IndexToNumMap) of
            {ok, OldNum} ->
                OldIndicesTree = maps:get(OldNum, NumToIndicesMap, gb_trees:empty()),
                UpdatedOldIndicesTree = gb_trees:delete(Index, OldIndicesTree),
                {OldNum, maps:put(OldNum, UpdatedOldIndicesTree, NumToIndicesMap)};
            _ ->
                {undefined, NumToIndicesMap}
        end,

    NewIndicesTree = maps:get(Number, NewNumToIndicesMap1, gb_trees:empty()),
    UpdatedNewIndicesTree = gb_trees:insert(Index, undefined, NewIndicesTree),
    NewNumToIndicesMap2 = maps:put(Number, UpdatedNewIndicesTree, NewNumToIndicesMap1),

    NewIndexToNumMap = maps:put(Index, Number, IndexToNumMap),

    #{index_to_num => NewIndexToNumMap,
      num_to_indices => NewNumToIndicesMap2
     }.

find(State, Number) ->
    NumToIndicesMap = maps:get(num_to_indices, State),
    case maps:find(Number, NumToIndicesMap) of
        {ok, IndicesTree} ->
            case gb_trees:is_empty(IndicesTree) of
                true -> -1;
                false ->
                    {MinIndex, _} = gb_trees:min(IndicesTree),
                    MinIndex
            end;
        _ ->
            -1
    end.