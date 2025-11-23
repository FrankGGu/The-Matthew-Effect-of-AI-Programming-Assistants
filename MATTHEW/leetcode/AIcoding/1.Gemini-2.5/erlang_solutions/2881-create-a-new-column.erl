-module(solution).
-export([find_final_value/2]).

find_final_value(Nums, Original) ->
    Set = sets:from_list(Nums),
    find_final_value_recursive(Set, Original).

find_final_value_recursive(Set, CurrentValue) ->
    case sets:is_element(CurrentValue, Set) of
        true ->
            find_final_value_recursive(Set, 2 * CurrentValue);
        false ->
            CurrentValue
    end.