-module(solution).
-export([earliestSecondToMarkIndices/2]).

earliestSecondToMarkIndices(Nums, ChangeIndices) ->
    N = length(Nums),
    M = length(ChangeIndices),

    NumsTuple = list_to_tuple([0 | Nums]),

    case check(M, N, NumsTuple, ChangeIndices) of
        false -> -1;
        true ->
            Low = 1,
            High = M,
            binary_search(Low, High, M, N, NumsTuple, ChangeIndices)
    end.

binary_search(Low, High, Ans, N, NumsTuple, ChangeIndices) ->
    if
        Low > High -> Ans;
        true ->
            Mid = Low + (High - Low) div 2,
            case check(Mid, N, NumsTuple, ChangeIndices) of
                true -> binary_search(Low, Mid - 1, Mid, N, NumsTuple, ChangeIndices);
                false -> binary_search(Mid + 1, High, Ans, N, NumsTuple, ChangeIndices)
            end
    end.

check(T, N, NumsTuple, ChangeIndices) ->
    LastOpTime = array:new({size, N + 1, default, 0}),

    UpdatedLastOpTime = lists:foldl(
        fun([S, Idx], AccLastOpTime) ->
            if
                S =< T -> array:set(Idx, S, AccLastOpTime);
                true -> AccLastOpTime
            end
        end,
        LastOpTime,
        ChangeIndices
    ),

    OpsAtTime = array:new({size, T + 1, default, []}),

    UpdatedOpsAtTime = lists:foldl(
        fun([S, Idx], AccOpsAtTime) ->
            if
                S =< T -> array:set(S, [Idx | array:get(S, AccOpsAtTime)], AccOpsAtTime);
                true -> AccOpsAtTime
            end
        end,
        OpsAtTime,
        ChangeIndices
    ),

    MarkedCount = 0,
    FreeOps = 0,

    check_loop(T, N, NumsTuple, UpdatedLastOpTime, UpdatedOpsAtTime, MarkedCount, FreeOps).

check_loop(S, N, NumsTuple, LastOpTime, OpsAtTime, MarkedCount, FreeOps) ->
    if
        S < 1 ->
            MarkedCount == N;
        true ->
            CurrentIndices = array:get(S, OpsAtTime),
            {NewMarkedCount, NewFreeOps} = lists:foldl(
                fun(Idx, {AccMarkedCount, AccFreeOps}) ->
                    if
                        array:get(Idx, LastOpTime) == S ->
                            RequiredDecrements = element(Idx, NumsTuple),
                            if
                                AccFreeOps >= RequiredDecrements ->
                                    {AccMarkedCount + 1, AccFreeOps - RequiredDecrements};
                                true ->
                                    {AccMarkedCount, AccFreeOps + 1}
                            end;
                        true ->
                            {AccMarkedCount, AccFreeOps + 1}
                    end
                end,
                {MarkedCount, FreeOps},
                CurrentIndices
            ),
            check_loop(S - 1, N, NumsTuple, LastOpTime, OpsAtTime, NewMarkedCount, NewFreeOps)
    end.