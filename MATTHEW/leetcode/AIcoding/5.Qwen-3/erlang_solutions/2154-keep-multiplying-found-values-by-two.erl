-module(solution).
-export([find_final_value/1]).

find_final_value(Nums) ->
    Set = sets:from_list(Nums),
    find_final_value(Set, 0).

find_final_value(Set, Value) ->
    case sets:is_element(Value, Set) of
        true -> find_final_value(Set, Value * 2);
        false -> Value
    end.