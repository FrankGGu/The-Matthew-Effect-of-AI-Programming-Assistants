-module(solution).
-export([max_operations/1]).

-spec max_operations(Nums :: [integer()]) -> integer().
max_operations(Nums) ->
    [H1, H2 | Rest] = Nums,
    TargetScore = H1 + H2,
    count_operations(Rest, TargetScore, 1).

count_operations([], _TargetScore, Count) ->
    Count;
count_operations([_SingleElement], _TargetScore, Count) ->
    Count;
count_operations([H1, H2 | T], TargetScore, Count) ->
    CurrentSum = H1 + H2,
    case CurrentSum == TargetScore of
        true ->
            count_operations(T, TargetScore, Count + 1);
        false ->
            Count
    end.