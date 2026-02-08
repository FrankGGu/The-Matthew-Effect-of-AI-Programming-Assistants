-spec can_complete_circuit(Gas :: [integer()], Cost :: [integer()]) -> integer().
can_complete_circuit(Gas, Cost) ->
    Total_Gas = lists:sum(Gas),
    Total_Cost = lists:sum(Cost),
    case Total_Gas >= Total_Cost of
        false -> -1;
        true ->
            can_complete_circuit_helper(Gas, Cost, 0, 0, 0)
    end.

-spec can_complete_circuit_helper(Gas :: [integer()], Cost :: [integer()], Current_Sum :: integer(), Start_Idx :: integer(), Current_Idx :: integer()) -> integer().
can_complete_circuit_helper([H | T], [C | Ct], Current_Sum, Start_Idx, Current_Idx) when Current_Sum + H - C >= 0 ->
    can_complete_circuit_helper(T, Ct, Current_Sum + H - C, Start_Idx, Current_Idx + 1);
can_complete_circuit_helper([H | T], [C | Ct], Current_Sum, Start_Idx, Current_Idx) when Current_Sum + H - C < 0 ->
    can_complete_circuit_helper(T ++ [H], Ct ++ [C], 0, Current_Idx + 1, 0);
can_complete_circuit_helper([], [], _, Start_Idx, _) -> Start_Idx.
