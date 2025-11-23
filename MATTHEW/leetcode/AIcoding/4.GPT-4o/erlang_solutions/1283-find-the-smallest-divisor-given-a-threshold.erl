-module(smallest_divisor).
-export([smallestDivisor/2]).

smallestDivisor(A, T) ->
    low = 1,
    high = lists:max(A),
    binary_search(low, high, A, T).

binary_search(Low, High, A, T) when Low < High ->
    Mid = (Low + High) div 2,
    Sum = lists:sum(lists:map(fun(X) -> (X + Mid - 1) div Mid end, A)),
    case Sum > T of
        true -> binary_search(Low, Mid, A, T);
        false -> binary_search(Mid + 1, High, A, T)
    end;
binary_search(Low, High, _, _) -> Low.