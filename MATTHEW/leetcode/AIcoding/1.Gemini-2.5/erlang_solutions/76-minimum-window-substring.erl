-module(solution).
-export([minWindow/2]).

minWindow(S, T) ->
    TargetCounts = count_chars(T, #{}).
    TargetUniqueChars = maps:size(TargetCounts).

    if TargetUniqueChars == 0 ->
        "";
    true ->
        S_array = array:from_list(S),
        S_len = array:size(S_array),

        InitialState = {0, #{}, 0, S_len + 1, -1},

        ResultState = expand_and_shrink(S_array, S_len, TargetCounts, TargetUniqueChars, 0, InitialState),

        {_Left, _CurrentWindowCounts, _MatchedChars, MinLen, MinStart} = ResultState,

        if MinLen == S_len + 1 ->
            "";
        true ->
            lists:sublist(S, MinStart + 1, MinLen)
        end
    end.

count_chars(Str, Acc) ->
    case Str of
        [] -> Acc;
        [H|T] -> 
            NewAcc = maps:update_with(H, fun(Count) -> Count + 1 end, 1, Acc),
            count_chars(T, NewAcc)
    end.

expand_and_shrink(S_array, S_len, TargetCounts, TargetUniqueChars, RightIdx, {LeftIdx, CurrentWindowCounts, MatchedChars, MinLen, MinStart}) when RightIdx < S_len ->
    CharR = array:get(RightIdx, S_array),

    NewCurrentWindowCounts = maps:update_with(CharR, fun(Count) -> Count + 1 end, 1, CurrentWindowCounts),

    NewMatchedChars = 
        case maps:find(CharR, TargetCounts) of
            {ok, TargetCount} ->
                case maps:find(CharR, NewCurrentWindowCounts) of
                    {ok, WindowCount} when WindowCount == TargetCount ->
                        MatchedChars + 1;
                    _ ->
                        MatchedChars
                end;
            _ ->
                MatchedChars
        end,

    UpdatedState = 
        if NewMatchedChars == TargetUniqueChars ->
            shrink_window(S_array, S_len, TargetCounts, TargetUniqueChars, RightIdx, {LeftIdx, NewCurrentWindowCounts, NewMatchedChars, MinLen, MinStart});
        true ->
            {LeftIdx, NewCurrentWindowCounts, NewMatchedChars, MinLen, MinStart}
        end,

    {FinalLeft, FinalCurrentWindowCounts, FinalMatchedChars, FinalMinLen, FinalMinStart} = UpdatedState,
    expand_and_shrink(S_array, S_len, TargetCounts, TargetUniqueChars, RightIdx + 1, {FinalLeft, FinalCurrentWindowCounts, FinalMatchedChars, FinalMinLen, FinalMinStart});
expand_and_shrink(_S_array, _S_len, _TargetCounts, _TargetUniqueChars, _RightIdx, FinalState) ->
    FinalState.

shrink_window(S_array, _S_len, TargetCounts, TargetUniqueChars, RightIdx, {LeftIdx, CurrentWindowCounts, MatchedChars, MinLen, MinStart}) ->
    CurrentLen = RightIdx - LeftIdx + 1,

    {NewMinLen, NewMinStart} = 
        if CurrentLen < MinLen ->
            {CurrentLen, LeftIdx};
        true ->
            {MinLen, MinStart}
        end,

    CharL = array:get(LeftIdx, S_array),

    NewCurrentWindowCounts = maps:update_with(CharL, fun(Count) -> Count - 1 end, 0, CurrentWindowCounts), 

    NewMatchedChars = 
        case maps:find(CharL, TargetCounts) of
            {ok, TargetCount} ->
                case maps:find(CharL, NewCurrentWindowCounts) of
                    {ok, WindowCount} when WindowCount < TargetCount ->
                        MatchedChars - 1;
                    _ ->
                        MatchedChars
                end;
            _ ->
                MatchedChars
        end,

    NewLeftIdx = LeftIdx + 1,

    if NewMatchedChars == TargetUniqueChars andalso NewLeftIdx <= RightIdx -> 
        shrink_window(S_array, _S_len, TargetCounts, TargetUniqueChars, RightIdx, {NewLeftIdx, NewCurrentWindowCounts, NewMatchedChars, NewMinLen, NewMinStart});
    true ->
        {NewLeftIdx, NewCurrentWindowCounts, NewMatchedChars, NewMinLen, NewMinStart}
    end.