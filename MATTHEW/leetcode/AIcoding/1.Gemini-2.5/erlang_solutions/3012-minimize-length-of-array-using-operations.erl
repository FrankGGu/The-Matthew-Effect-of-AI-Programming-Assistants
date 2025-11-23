-module(solution).
-export([min_length/1]).

min_length(Nums) ->
    min_length_recursive(Nums, 0, 0).

min_length_recursive([], CurrentSum, FinalCount) ->
    case CurrentSum > 0 of
        true -> FinalCount + 1;
        false -> FinalCount
    end;
min_length_recursive([H|T], CurrentSum, FinalCount) ->
    if
        CurrentSum == 0 ->
            min_length_recursive(T, H, FinalCount);
        CurrentSum =< H ->
            min_length_recursive(T, CurrentSum + H, FinalCount);
        true -> %% CurrentSum > H
            min_length_recursive(T, H, FinalCount + 1)
    end.