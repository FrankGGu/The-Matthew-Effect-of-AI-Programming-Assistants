-module(minimum_space_wasted_from_packaging).
-export([minSpaceWaste/2]).

minSpaceWaste(Packages, Boxes) ->
    SortedBoxes = lists:sort(Boxes),
    SortedPackages = lists:sort(Packages),
    minSpaceWaste(SortedPackages, SortedBoxes, 0).

minSpaceWaste([], _, Acc) ->
    Acc;
minSpaceWaste([P | Ps], Boxes, Acc) ->
    {Box, Rest} = findFirstBoxNotLessThan(P, Boxes),
    case Box of
        undefined ->
            Acc;
        _ ->
            NewAcc = Acc + (Box - P),
            minSpaceWaste(Ps, Rest, NewAcc)
    end.

findFirstBoxNotLessThan(_, []) ->
    {undefined, []};
findFirstBoxNotLessThan(X, [B | Bs]) ->
    if
        B >= X ->
            {B, Bs};
        true ->
            findFirstBoxNotLessThan(X, Bs)
    end.