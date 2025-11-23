-module(solution).
-export([semi_ordered_permutation/1]).

semi_ordered_permutation/1 ->
    Input = lists:seq(1, 1000),
    semi_ordered_permutation(Input).

semi_ordered_permutation(List) ->
    Sorted = lists:sort(List),
    {Front, Back} = lists:split(2, Sorted),
    FrontLength = length(Front),
    BackLength = length(Back),
    ValidCount = lists:foldl(fun(X, Acc) -> if
        lists:member(X, Front) -> Acc + 1;
        true -> Acc
    end, 0, List),
    ValidCount + (FrontLength + BackLength - ValidCount).