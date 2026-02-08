-module(solution).
-export([max_energy/1]).

max_energy(Energy) ->
    max_energy(Energy, 0, 0, []).

max_energy([], _, _, Acc) ->
    lists:max(Acc);
max_energy([H | T], Row, Col, Acc) ->
    NewAcc = case Col of
        0 -> [H | Acc];
        _ -> [lists:nth(Col, Acc) + H | Acc]
    end,
    max_energy(T, Row + 1, Col + 1, NewAcc).