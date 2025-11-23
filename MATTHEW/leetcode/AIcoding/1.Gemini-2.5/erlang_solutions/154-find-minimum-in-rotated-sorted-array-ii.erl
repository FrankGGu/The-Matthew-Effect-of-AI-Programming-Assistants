-module(solution).
-export([findMin/1]).

findMin(Nums) ->
    Arr = array:from_list(Nums),
    ListLen = length(Nums),
    findMin(Arr, 0, ListLen - 1).

findMin(Arr, Low, High) when Low < High ->
    Mid = Low + (High - Low) div 2,
    MidVal = array:get(Mid, Arr),
    HighVal = array:get(High, Arr),

    if
        MidVal < HighVal ->
            findMin(Arr, Low, Mid);
        MidVal > HighVal ->
            findMin(Arr, Mid + 1, High);
        true -> % MidVal == HighVal
            findMin(Arr, Low, High - 1)
    end;
findMin(Arr, Low, High) when Low == High ->
    array:get(Low, Arr).