-module(max_distance_between_a_pair_of_values).
-export([maxDistance/2]).

maxDistance(Values1, Values2) ->
    maxDistance(Values1, Values2, 0, 0, -1).

maxDistance([], _, _, _, Acc) ->
    Acc;
maxDistance(_, [], _, _, Acc) ->
    Acc;
maxDistance([V1 | T1], [V2 | T2], I, J, Acc) ->
    if
        V1 > V2 ->
            maxDistance(T1, [V2 | T2], I + 1, J, Acc);
        V1 < V2 ->
            maxDistance([V1 | T1], T2, I, J + 1, Acc);
        true ->
            NewAcc = if Acc == -1 -> J - I; true -> max(Acc, J - I) end,
            maxDistance(T1, T2, I + 1, J + 1, NewAcc)
    end.