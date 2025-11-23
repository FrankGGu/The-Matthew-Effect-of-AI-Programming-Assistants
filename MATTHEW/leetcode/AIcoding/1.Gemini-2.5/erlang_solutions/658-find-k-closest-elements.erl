-module(solution).
-export([find_closest_elements/3]).

find_closest_elements(Arr, K, X) ->
    N = length(Arr),
    TupleArr = list_to_tuple(Arr),
    Low = 0,
    High = N - K,
    StartIndex = find_closest_elements_bs(TupleArr, K, X, Low, High),

    [element(I, TupleArr) || I <- lists:seq(StartIndex + 1, StartIndex + K)].

find_closest_elements_bs(TupleArr, K, X, Low, High) when Low < High ->
    Mid = Low + (High - Low) div 2,

    ArrMid = element(Mid + 1, TupleArr),
    ArrMidPlusK = element(Mid + K + 1, TupleArr),

    if (X - ArrMid) > (ArrMidPlusK - X) then
        find_closest_elements_bs(TupleArr, K, X, Mid + 1, High)
    else
        find_closest_elements_bs(TupleArr, K, X, Low, Mid)
    end;
find_closest_elements_bs(_TupleArr, _K, _X, Low, _High) ->
    Low.