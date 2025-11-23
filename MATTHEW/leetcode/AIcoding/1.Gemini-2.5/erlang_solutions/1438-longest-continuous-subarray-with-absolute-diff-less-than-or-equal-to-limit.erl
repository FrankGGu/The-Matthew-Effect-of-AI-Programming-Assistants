-module(solution).
-export([longest_subarray/2]).

longest_subarray(Nums, Limit) ->
    Array = array:from_list(Nums),
    ArraySize = array:size(Array),
    longest_subarray_impl(Array, ArraySize, Limit, 0, 0, queue:new(), queue:new(), 0).

longest_subarray_impl(Array, ArraySize, Limit, Left, Right, MaxDeque, MinDeque, MaxLen) ->
    case Right < ArraySize of
        true ->
            CurrentVal = array:get(Right, Array),

            MaxDeque1 = remove_indices_with_smaller_val_from_back(MaxDeque, Array, CurrentVal),
            MaxDeque2 = queue:in(Right, MaxDeque1),

            MinDeque1 = remove_indices_with_larger_val_from_back(MinDeque, Array, CurrentVal),
            MinDeque2 = queue:in(Right, MinDeque1),

            {NewLeft, NewMaxDeque, NewMinDeque} =
                shrink_window(Array, Limit, Left, MaxDeque2, MinDeque2),

            NewMaxLen = max(MaxLen, Right - NewLeft + 1),

            longest_subarray_impl(Array, ArraySize, Limit, NewLeft, Right + 1, NewMaxDeque, NewMinDeque, NewMaxLen);
        false ->
            MaxLen
    end.

remove_indices_with_smaller_val_from_back(Q, Array, Val) ->
    case queue:is_empty(Q) of
        true -> Q;
        false ->
            {BackIdx, _} = queue:last(Q),
            BackVal = array:get(BackIdx, Array),
            case BackVal < Val of
                true ->
                    {_, Q1} = queue:out_r(Q),
                    remove_indices_with_smaller_val_from_back(Q1, Array, Val);
                false -> Q
            end
    end.

remove_indices_with_larger_val_from_back(Q, Array, Val) ->
    case queue:is_empty(Q) of
        true -> Q;
        false ->
            {BackIdx, _} = queue:last(Q),
            BackVal = array:get(BackIdx, Array),
            case BackVal > Val of
                true ->
                    {_, Q1} = queue:out_r(Q),
                    remove_indices_with_larger_val_from_back(Q1, Array, Val);
                false -> Q
            end
    end.

shrink_window(Array, Limit, Left, MaxDeque, MinDeque) ->
    case queue:is_empty(MaxDeque) orElse queue:is_empty(MinDeque) of
        true -> {Left, MaxDeque, MinDeque};
        false ->
            MaxIdx = queue:head(MaxDeque),
            MinIdx = queue:head(MinDeque),

            MaxVal = array:get(MaxIdx, Array),
            MinVal = array:get(MinIdx, Array),

            case (MaxVal - MinVal) > Limit of
                true ->
                    NewLeft = Left + 1,

                    NewMaxDeque = case MaxIdx < NewLeft of
                                      true -> queue:tail(MaxDeque);
                                      false -> MaxDeque
                                  end,
                    NewMinDeque = case MinIdx < NewLeft of
                                      true -> queue:tail(MinDeque);
                                      false -> MinDeque
                                  end,
                    shrink_window(Array, Limit, NewLeft, NewMaxDeque, NewMinDeque);
                false ->
                    {Left, MaxDeque, MinDeque}
            end
    end.