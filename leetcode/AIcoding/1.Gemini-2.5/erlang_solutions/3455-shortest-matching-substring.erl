-module(solution).
-export([min_window/2]).

min_window(S, T) ->
    S_len = length(S),
    T_len = length(T),

    if T_len == 0 ->
        "";
       S_len < T_len ->
        "";
       true ->
        TargetCounts = lists:foldl(fun(C, Acc) ->
                                        maps:update_with(C, fun(V) -> V + 1 end, 1, Acc)
                                end, #{}, T),
        TargetUniqueChars = maps:size(TargetCounts),

        S_array = array:from_list(S),

        min_window_iter(0, 0, #{}, 0, S_len + 1, -1, TargetCounts, TargetUniqueChars, S_array, S_len, S)
    end.

min_window_iter(RightPtr, LeftPtr, WindowCounts, MatchedChars, MinLen, MinStartIdx, TargetCounts, TargetUniqueChars, S_array, S_len, S_original_list) when RightPtr < S_len ->
    CharR = array:get(RightPtr, S_array),

    NewWindowCounts = maps:update_with(CharR, fun(V) -> V + 1 end, 1, WindowCounts),

    NewMatchedChars =
        case maps:find(CharR, TargetCounts) of
            {ok, TargetCountR} ->
                case maps:find(CharR, NewWindowCounts) of
                    {ok, WindowCountR} when WindowCountR == TargetCountR -> MatchedChars + 1;
                    _ -> MatchedChars
                end;
            _ -> MatchedChars
        end,

    shrink_window(LeftPtr, RightPtr + 1, NewWindowCounts, NewMatchedChars, MinLen, MinStartIdx, TargetCounts, TargetUniqueChars, S_array, S_len, S_original_list);

min_window_iter(RightPtr, LeftPtr, WindowCounts, MatchedChars, MinLen, MinStartIdx, TargetCounts, TargetUniqueChars, S_array, S_len, S_original_list) when RightPtr == S_len ->
    shrink_window(LeftPtr, RightPtr, WindowCounts, MatchedChars, MinLen, MinStartIdx, TargetCounts, TargetUniqueChars, S_array, S_len, S_original_list);

min_window_iter(_RightPtr, _LeftPtr, _WindowCounts, _MatchedChars, MinLen, MinStartIdx, _TargetCounts, _TargetUniqueChars, _S_array, _S_len, S_original_list) ->
    if MinStartIdx == -1 ->
        "";
    true ->
        lists:sublist(S_original_list, MinStartIdx + 1, MinLen)
    end.

shrink_window(LeftPtr, RightPtrExclusive, WindowCounts, MatchedChars, MinLen, MinStartIdx, TargetCounts, TargetUniqueChars, S_array, S_len, S_original_list) ->
    if MatchedChars == TargetUniqueChars ->
        CurrentLen = RightPtrExclusive - LeftPtr,
        {NewMinLen, NewMinStartIdx} =
            if CurrentLen < MinLen ->
                {CurrentLen, LeftPtr};
            true ->
                {MinLen, MinStartIdx}
            end,

        CharL = array:get(LeftPtr, S_array),
        NewWindowCounts = maps:update_with(CharL, fun(V) -> V - 1 end, 0, WindowCounts),

        NewMatchedChars =
            case maps:find(CharL, TargetCounts) of
                {ok, TargetCountL} ->
                    case maps:find(CharL, WindowCounts) of
                        {ok, WindowCountL} when WindowCountL == TargetCountL -> MatchedChars - 1;
                        _ -> MatchedChars
                    end;
                _ -> MatchedChars
            end,

        shrink_window(LeftPtr + 1, RightPtrExclusive, NewWindowCounts, NewMatchedChars, NewMinLen, NewMinStartIdx, TargetCounts, TargetUniqueChars, S_array, S_len, S_original_list);
    true ->
        min_window_iter(RightPtrExclusive, LeftPtr, WindowCounts, MatchedChars, MinLen, MinStartIdx, TargetCounts, TargetUniqueChars, S_array, S_len, S_original_list)
    end.