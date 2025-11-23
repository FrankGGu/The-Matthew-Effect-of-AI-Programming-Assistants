-module(solution).
-export([find_indices/3]).

-spec find_indices(Nums :: [integer()], IndexDifference :: integer(), ValueDifference :: integer()) -> [integer(), integer()].
find_indices(Nums, IndexDifference, ValueDifference) ->
    Arr = array:from_list(Nums),
    Len = array:size(Arr),
    find_indices_loop_i(0, Arr, Len, IndexDifference, ValueDifference).

find_indices_loop_i(I, Arr, Len, IndexDifference, ValueDifference) when I < Len ->
    find_indices_loop_j(I, 0, Arr, Len, IndexDifference, ValueDifference);
find_indices_loop_i(_I, _Arr, _Len, _IndexDifference, _ValueDifference) ->
    [-1, -1].

find_indices_loop_j(I, J, Arr, Len, IndexDifference, ValueDifference) when J < Len ->
    AbsIndexDiff = abs(I - J),
    case AbsIndexDiff >= IndexDifference of
        true ->
            NumI = array:get(I, Arr),
            NumJ = array:get(J, Arr),
            AbsValueDiff = abs(NumI - NumJ),
            case AbsValueDiff >= ValueDifference of
                true ->
                    [I, J];
                false ->
                    find_indices_loop_j(I, J + 1, Arr, Len, IndexDifference, ValueDifference)
            end;
        false ->
            find_indices_loop_j(I, J + 1, Arr, Len, IndexDifference, ValueDifference)
    end;
find_indices_loop_j(I, _J, Arr, Len, IndexDifference, ValueDifference) ->
    find_indices_loop_i(I + 1, Arr, Len, IndexDifference, ValueDifference).