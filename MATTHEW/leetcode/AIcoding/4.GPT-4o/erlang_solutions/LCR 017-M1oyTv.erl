-module(solution).
-export([min_window/2]).

min_window(S, T) ->
    % Convert strings to lists of characters
    SChars = string:to_list(S),
    TChars = string:to_list(T),
    Freq = frequency(TChars),
    min_window_helper(SChars, Freq, [], infinity, {0, 0}).

min_window_helper([], _Freq, _Current, MinLen, Result) ->
    case MinLen of
        infinity -> "";
        _ -> lists:sublist(Result, 1, MinLen)
    end;
min_window_helper(SChars, Freq, CurrentFreq, MinLen, Result) ->
    {StartIdx, EndIdx, NewCurrentFreq} = 
        find_window(SChars, Freq, CurrentFreq, 0, 0, 0, 0),
    if
        EndIdx > StartIdx ->
            NewMinLen = EndIdx - StartIdx + 1,
            NewResult = lists:sublist(SChars, StartIdx, NewMinLen),
            min_window_helper(tl(SChars), Freq, NewCurrentFreq, min(MinLen, NewMinLen), NewResult);
        true ->
            ""
    end.

find_window([], _Freq, CurrentFreq, StartIdx, EndIdx, _CurrentCount, _Idx) ->
    {StartIdx, EndIdx, CurrentFreq};
find_window([C | Rest], Freq, CurrentFreq, StartIdx, EndIdx, CurrentCount, Idx) ->
    NewCurrentFreq = update_freq(CurrentFreq, C, 1),
    NewCount = if maps:is_key(C, Freq) -> CurrentCount + 1; true -> CurrentCount end,
    if 
        NewCount >= maps:size(Freq) ->
            find_window(Rest, Freq, NewCurrentFreq, StartIdx, Idx + 1, NewCount, Idx + 1);
        true ->
            find_window(Rest, Freq, NewCurrentFreq, StartIdx, EndIdx, NewCount, Idx + 1)
    end.

frequency(Chars) ->
    lists:foldl(fun C, Acc -> maps:update_with(C, fun(X) -> X + 1 end, fun() -> 1 end, Acc) end, #{} , Chars).

update_freq(Freq, Char, Delta) ->
    maps:update_with(Char, fun(X) -> X + Delta end, fun() -> Delta end, Freq).