-module(solution).
-export([max_distance/2]).

-include_lib("stdlib/include/array.hrl").

max_distance(Nums1, Nums2) ->
    Arr1 = array:from_list(Nums1),
    Arr2 = array:from_list(Nums2),
    N1 = array:size(Arr1),
    N2 = array:size(Arr2),
    max_distance_recursive(Arr1, Arr2, N1, N2, 0, 0, 0).

max_distance_recursive(_Arr1, _Arr2, N1, N2, I, J, MaxDist) when I >= N1; J >= N2 ->
    MaxDist;
max_distance_recursive(Arr1, Arr2, N1, N2, I, J, MaxDist) ->
    Val1 = array:get(I, Arr1),
    Val2 = array:get(J, Arr2),
    if
        Val1 =< Val2 ->
            NewMaxDist = max(MaxDist, J - I),
            max_distance_recursive(Arr1, Arr2, N1, N2, I, J + 1, NewMaxDist);
        true -> % Val1 > Val2
            NewI = I + 1,
            NewJ = max(J, NewI),
            max_distance_recursive(Arr1, Arr2, N1, N2, NewI, NewJ, MaxDist)
    end.