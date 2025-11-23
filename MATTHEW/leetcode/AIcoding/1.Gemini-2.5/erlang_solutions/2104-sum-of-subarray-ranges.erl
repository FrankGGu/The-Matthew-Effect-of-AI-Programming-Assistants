-module(solution).
-export([subarray_ranges/1]).

subarray_ranges(NumsList) ->
    N = length(NumsList),
    Nums = list_to_tuple(NumsList),

    LeftMax = get_left_boundaries(Nums, N, fun(ValStack, ValCurrent) -> ValStack =< ValCurrent end, -1),
    RightMax = get_right_boundaries(Nums, N, fun(ValStack, ValCurrent) -> ValStack < ValCurrent end, N),

    LeftMin = get_left_boundaries(Nums, N, fun(ValStack, ValCurrent) -> ValStack >= ValCurrent end, -1),
    RightMin = get_right_boundaries(Nums, N, fun(ValStack, ValCurrent) -> ValStack > ValCurrent end, N),

    calculate_total_sum(Nums, N, LeftMax, RightMax, LeftMin, RightMin).

get_value(NumsTuple, Index) ->
    element(Index + 1, NumsTuple).

get_left_boundaries(Nums, N, CmpFun, DefaultVal) ->
    lists:foldl(fun(CurrentIdx, {Stack, Acc}) ->
        CurrentVal = get_value(Nums, CurrentIdx),
        {NewStack, BoundaryIdx} = pop_stack_for_left(Nums, CurrentVal, CmpFun, Stack, DefaultVal),
        {NewStack, [BoundaryIdx | Acc]}
    end, {[], []}, lists:seq(0, N-1))
    |> fun({_Stack, Acc}) -> lists:reverse(Acc) end.

pop_stack_for_left(Nums, CurrentVal, CmpFun, Stack, DefaultVal) ->
    case Stack of
        [] -> {[], DefaultVal};
        [StackTopIdx | RestStack] ->
            StackTopVal = get_value(Nums, StackTopIdx),
            if CmpFun(StackTopVal, CurrentVal) ->
                pop_stack_for_left(Nums, CurrentVal, CmpFun, RestStack, DefaultVal);
            true ->
                {Stack, StackTopIdx}
            end
    end.

get_right_boundaries(Nums, N, CmpFun, DefaultVal) ->
    lists:foldl(fun(CurrentIdx, {Stack, Acc}) ->
        CurrentVal = get_value(Nums, CurrentIdx),
        {NewStack, BoundaryIdx} = pop_stack_for_right(Nums, CurrentVal, CmpFun, Stack, DefaultVal),
        {NewStack, [BoundaryIdx | Acc]}
    end, {[], []}, lists:seq(N-1, 0, -1))
    |> fun({_Stack, Acc}) -> Acc end.

pop_stack_for_right(Nums, CurrentVal, CmpFun, Stack, DefaultVal) ->
    case Stack of
        [] -> {[], DefaultVal};
        [StackTopIdx | RestStack] ->
            StackTopVal = get_value(Nums, StackTopIdx),
            if CmpFun(StackTopVal, CurrentVal) ->
                pop_stack_for_right(Nums, CurrentVal, CmpFun, RestStack, DefaultVal);
            true ->
                {Stack, StackTopIdx}
            end
    end.

calculate_total_sum(Nums, N, LeftMax, RightMax, LeftMin, RightMin) ->
    LeftMaxT = list_to_tuple(LeftMax),
    RightMaxT = list_to_tuple(RightMax),
    LeftMinT = list_to_tuple(LeftMin),
    RightMinT = list_to_tuple(RightMin),

    lists:foldl(fun(Idx, Acc) ->
        Val = get_value(Nums, Idx),
        Lm = get_value(LeftMaxT, Idx),
        Rm = get_value(RightMaxT, Idx),
        Ln = get_value(LeftMinT, Idx),
        Rn = get_value(RightMinT, Idx),

        MaxContribution = Val * (Idx - Lm) * (Rm - Idx),
        MinContribution = Val * (Idx - Ln) * (Rn - Idx),

        Acc + MaxContribution - MinContribution
    end, 0, lists:seq(0, N-1)).