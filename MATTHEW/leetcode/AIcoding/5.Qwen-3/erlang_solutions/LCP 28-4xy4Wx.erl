-module(solution).
-export([num_ways/2]).

num_ways(Cost, MaxTotal) ->
    num_ways(Cost, MaxTotal, 0, 0).

num_ways([], _, _, Acc) ->
    Acc;
num_ways([H | T], MaxTotal, Index, Acc) ->
    if
        H > MaxTotal ->
            num_ways(T, MaxTotal, Index + 1, Acc);
        true ->
            num_ways(T, MaxTotal, Index + 1, Acc + 1)
    end.