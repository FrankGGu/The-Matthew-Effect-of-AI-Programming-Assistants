-spec first_missing_positive(Nums :: [integer()]) -> integer().
first_missing_positive(Nums) ->
    N = length(Nums),
    NumsArray = array:from_list(Nums),
    Modified = modify_array(NumsArray, N),
    find_missing(Modified, N).

modify_array(Array, N) ->
    modify_array(Array, N, 1).

modify_array(Array, N, I) when I =< N ->
    Value = array:get(I - 1, Array),
    if
        Value > 0, Value =< N ->
            TargetPos = Value - 1,
            TargetValue = array:get(TargetPos, Array),
            if
                TargetValue =/= Value ->
                    NewArray = array:set(TargetPos, Value, Array),
                    NewArray2 = array:set(I - 1, TargetValue, NewArray),
                    modify_array(NewArray2, N, I);
                true ->
                    modify_array(Array, N, I + 1)
            end;
        true ->
            modify_array(Array, N, I + 1)
    end;
modify_array(Array, _, _) ->
    Array.

find_missing(Array, N) ->
    find_missing(Array, N, 1).

find_missing(Array, N, I) when I =< N ->
    Value = array:get(I - 1, Array),
    if
        Value =/= I ->
            I;
        true ->
            find_missing(Array, N, I + 1)
    end;
find_missing(_, N, _) ->
    N + 1.