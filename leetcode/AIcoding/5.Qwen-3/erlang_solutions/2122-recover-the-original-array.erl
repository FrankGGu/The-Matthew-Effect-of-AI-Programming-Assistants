-module(recover_original_array).
-export([recoverable_magnitude/1]).

recoverable_magnitude(Nums) ->
    N = length(Nums),
    Sorted = lists:sort(Nums),
    Left = 0,
    Right = N - 1,
    Result = [],
    recoverable_magnitude(Sorted, Left, Right, Result).

recoverable_magnitude(_, _, _, Result) when length(Result) == (length(Nums) div 2) ->
    Result;

recoverable_magnitude(Sorted, Left, Right, Result) ->
    case Sorted -- [lists:nth(Left + 1, Sorted), lists:nth(Right + 1, Sorted)] of
        _ when lists:nth(Left + 1, Sorted) == lists:nth(Right + 1, Sorted) ->
            NewResult = [lists:nth(Left + 1, Sorted) | Result],
            recoverable_magnitude(Sorted, Left + 1, Right - 1, NewResult);
        _ ->
            NewResult = [lists:nth(Left + 1, Sorted) | Result],
            recoverable_magnitude(Sorted, Left + 1, Right - 1, NewResult)
    end.