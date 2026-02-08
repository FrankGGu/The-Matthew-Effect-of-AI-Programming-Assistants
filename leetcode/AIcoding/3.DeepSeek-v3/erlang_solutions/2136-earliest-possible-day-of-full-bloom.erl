-module(solution).
-export([earliest_full_bloom/2]).

earliest_full_bloom(PlantTime, GrowTime) ->
    Indices = lists:seq(0, length(PlantTime) - 1),
    Sorted = lists:sort(fun(I, J) -> 
                            lists:nth(I + 1, GrowTime) > lists:nth(J + 1, GrowTime) 
                        end, Indices),
    {Total, Current} = lists:foldl(fun(Idx, {T, C}) ->
                                      P = lists:nth(Idx + 1, PlantTime),
                                      G = lists:nth(Idx + 1, GrowTime),
                                      NewC = C + P,
                                      NewT = max(T, NewC + G),
                                      {NewT, NewC}
                                  end, {0, 0}, Sorted),
    Total.