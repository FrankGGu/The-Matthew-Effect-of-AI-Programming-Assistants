-module(solution).
-export([numComponents/2]).

numComponents(Head, Nums) ->
    NumSet = gb_sets:from_list(Nums),
    count_components_recursive(Head, NumSet, false, 0).

count_components_recursive(nil, _NumSet, _InComponent, CurrentCount) ->
    CurrentCount;
count_components_recursive({node, Val, Next}, NumSet, InComponent, CurrentCount) ->
    case gb_sets:is_member(Val, NumSet) of
        true ->
            case InComponent of
                false ->
                    count_components_recursive(Next, NumSet, true, CurrentCount + 1);
                true ->
                    count_components_recursive(Next, NumSet, true, CurrentCount)
            end;
        false ->
            count_components_recursive(Next, NumSet, false, CurrentCount)
    end.