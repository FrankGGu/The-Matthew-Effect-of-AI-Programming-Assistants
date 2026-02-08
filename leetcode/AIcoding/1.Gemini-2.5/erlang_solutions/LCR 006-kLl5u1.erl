-module(solution).
-export([two_sum/2]).

two_sum(Numbers, Target) ->
    Arr = array:from_list(Numbers),
    Len = array:size(Arr),

    find_pair(Arr, Target, 1, Len).

find_pair(Arr, Target, Left, Right) when Left < Right ->
    NumL = array:get(Left - 1, Arr),
    NumR = array:get(Right - 1, Arr),

    Sum = NumL + NumR,

    if
        Sum == Target ->
            {Left, Right};
        Sum < Target ->
            find_pair(Arr, Target, Left + 1, Right);
        Sum > Target ->
            find_pair(Arr, Target, Left, Right - 1)
    end;
find_pair(_Arr, _Target, _Left, _Right) ->
    % This case should not be reached based on problem constraints (exactly one solution exists).
    error(no_solution).