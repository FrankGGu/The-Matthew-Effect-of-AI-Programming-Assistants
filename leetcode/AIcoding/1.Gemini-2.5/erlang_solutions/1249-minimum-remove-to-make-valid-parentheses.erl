-module(solution).
-export([minRemoveToMakeValid/1]).

minRemoveToMakeValid(S) ->
    {IndicesToRemove, _FinalStack} = find_indices_to_remove(S, 0, [], gb_sets:new()),
    build_result_string(S, 0, IndicesToRemove, []).

find_indices_to_remove([], _Index, Stack, ToRemove) ->
    FinalToRemove = lists:foldl(fun(Idx, AccSet) -> gb_sets:add(Idx, AccSet) end, ToRemove, Stack),
    {FinalToRemove, []};
find_indices_to_remove([$(|T], Index, Stack, ToRemove) ->
    find_indices_to_remove(T, Index + 1, [Index|Stack], ToRemove);
find_indices_to_remove([$)|T], Index, [OpenParenIdx|RestStack], ToRemove) ->
    find_indices_to_remove(T, Index + 1, RestStack, ToRemove);
find_indices_to_remove([$)|T], Index, [], ToRemove) ->
    NewToRemove = gb_sets:add(Index, ToRemove),
    find_indices_to_remove(T, Index + 1, [], NewToRemove);
find_indices_to_remove([_H|T], Index, Stack, ToRemove) ->
    find_indices_to_remove(T, Index + 1, Stack, ToRemove).

build_result_string([], _Index, _ToRemove, Acc) ->
    lists:reverse(Acc);
build_result_string([H|T], Index, ToRemove, Acc) ->
    case gb_sets:is_member(Index, ToRemove) of
        true ->
            build_result_string(T, Index + 1, ToRemove, Acc);
        false ->
            build_result_string(T, Index + 1, ToRemove, [H|Acc])
    end.