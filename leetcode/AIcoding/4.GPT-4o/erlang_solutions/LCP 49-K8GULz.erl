-module(solution).
-export([can_complete_circuit/1]).

can_complete_circuit(C) ->
    N = length(C),
    can_complete_circuit_helper(C, N, 0, 0, 0).

can_complete_circuit_helper(_, N, Start, TotalGas, TotalCost) when Start >= N ->
    if TotalGas >= TotalCost ->
        Start;
    true ->
        -1
    end;
can_complete_circuit_helper(C, N, Start, TotalGas, TotalCost) ->
    {Gas, Cost} = lists:nth(Start + 1, C),
    can_complete_circuit_helper(C, N, Start + 1, TotalGas + Gas, TotalCost + Cost).