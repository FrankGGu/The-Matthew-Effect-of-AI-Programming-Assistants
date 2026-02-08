-module(fair_candy_swap).
-export([fairCandySwap/2]).

fairCandySwap(A, B) ->
    SumA = lists:sum(A),
    SumB = lists:sum(B),
    Diff = (SumA - SumB) div 2,
    SetB = sets:from_list(B),
    FindMatch(A, SetB, Diff).

FindMatch([], _, _) ->
    [];
FindMatch([X | T], SetB, Diff) ->
    Y = X - Diff,
    case sets:is_element(Y, SetB) of
        true ->
            [X, Y];
        false ->
            FindMatch(T, SetB, Diff)
    end.