-module(solution).
-export([make_array_increasing/2]).

make_array_increasing(Arr1, Arr2) ->
    Arr2Sorted = lists:usort(Arr2),
    N = length(Arr1),
    DP = maps:from_list([{0, -1}]),
    {_, Result} = lists:foldl(fun(I, {DPAcc, _}) ->
        NewDP = maps:new(),
        {PrevKeys, _} = lists:unzip(maps:to_list(DPAcc)),
        lists:foldl(fun(PrevKey, _) ->
            PrevVal = maps:get(PrevKey, DPAcc),
            CurrentVal = lists:nth(I, Arr1),
            if
                CurrentVal > PrevVal ->
                    case maps:find(PrevKey + 1, NewDP) of
                        {ok, ExistingVal} when ExistingVal =< CurrentVal ->
                            ok;
                        _ ->
                            NewDP1 = maps:put(PrevKey + 1, CurrentVal, NewDP),
                            NewDP1
                    end;
                true ->
                    ok
            end,
            case binary_search(Arr2Sorted, PrevVal) of
                -1 ->
                    ok;
                ReplaceVal ->
                    case maps:find(PrevKey + 1, NewDP) of
                        {ok, ExistingVal} when ExistingVal =< ReplaceVal ->
                            ok;
                        _ ->
                            NewDP1 = maps:put(PrevKey + 1, ReplaceVal, NewDP),
                            NewDP1
                    end
            end
        end, ok, PrevKeys),
        {NewDP, NewDP}
    end, {DP, DP}, lists:seq(1, N)),
    case maps:size(Result) of
        0 -> -1;
        _ -> lists:min(maps:keys(Result))
    end.

binary_search(List, Target) ->
    binary_search(List, Target, 1, length(List)).

binary_search(List, Target, Low, High) ->
    if
        Low > High -> -1;
        true ->
            Mid = (Low + High) div 2,
            MidVal = lists:nth(Mid, List),
            if
                MidVal > Target ->
                    if
                        Mid =:= 1 -> MidVal;
                        true ->
                            PrevVal = lists:nth(Mid - 1, List),
                            if
                                PrevVal =< Target -> MidVal;
                                true -> binary_search(List, Target, Low, Mid - 1)
                            end
                    end;
                true ->
                    binary_search(List, Target, Mid + 1, High)
            end
    end.