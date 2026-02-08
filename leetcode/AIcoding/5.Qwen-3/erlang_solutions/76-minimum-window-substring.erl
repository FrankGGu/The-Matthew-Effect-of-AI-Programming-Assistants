-module(minimum_window_substring).
-export([min_window/2]).

min_window(S, T) ->
    case length(T) of
        0 -> "";
        _ ->
            LenT = length(T),
            LenS = length(S),
            Map = maps:from_list([{Char, 0} || Char <- T]),
            RequiredChars = LenT,
            CurrentChars = 0,
            Left = 1,
            Right = 1,
            MinLen = infinity,
            MinLeft = 0,
            MinRight = 0,
            State = {Map, RequiredChars, CurrentChars, Left, Right, MinLen, MinLeft, MinRight},
            find_window(State, S, T, LenS, LenT)
    end.

find_window({Map, RequiredChars, CurrentChars, Left, Right, MinLen, MinLeft, MinRight}, S, T, LenS, LenT) when Right > LenS ->
    case MinLen of
        infinity -> "";
        _ -> substring(S, MinLeft, MinRight)
    end;
find_window({Map, RequiredChars, CurrentChars, Left, Right, MinLen, MinLeft, MinRight}, S, T, LenS, LenT) ->
    Char = lists:nth(Right, S),
    case maps:is_key(Char, Map) of
        true ->
            NewMap = maps:update(Char, maps:get(Char, Map) + 1),
            if maps:get(Char, NewMap) == 1 -> NewCurrentChars = CurrentChars + 1; true -> NewCurrentChars = CurrentChars end,
            case NewCurrentChars of
                RequiredChars ->
                    % Try to shrink window from left
                    NewState = {NewMap, RequiredChars, NewCurrentChars, Left, Right, MinLen, MinLeft, MinRight},
                    shrink_window(NewState, S, T, LenS, LenT);
                _ ->
                    NewState = {NewMap, RequiredChars, NewCurrentChars, Left, Right + 1, MinLen, MinLeft, MinRight},
                    find_window(NewState, S, T, LenS, LenT)
            end;
        false ->
            NewState = {Map, RequiredChars, CurrentChars, Left, Right + 1, MinLen, MinLeft, MinRight},
            find_window(NewState, S, T, LenS, LenT)
    end.

shrink_window({Map, RequiredChars, CurrentChars, Left, Right, MinLen, MinLeft, MinRight}, S, T, LenS, LenT) ->
    Char = lists:nth(Left, S),
    case maps:is_key(Char, Map) of
        true ->
            if maps:get(Char, Map) > 1 -> NewMap = maps:update(Char, maps:get(Char, Map) - 1); true -> NewMap = maps:remove(Char, Map) end,
            NewCurrentChars = CurrentChars - 1,
            NewMinLen = Right - Left + 1,
            NewMinLeft = Left,
            NewMinRight = Right,
            case NewMinLen < MinLen of
                true ->
                    NewState = {NewMap, RequiredChars, NewCurrentChars, Left + 1, Right, NewMinLen, NewMinLeft, NewMinRight};
                false ->
                    NewState = {NewMap, RequiredChars, NewCurrentChars, Left + 1, Right, MinLen, MinLeft, MinRight}
            end,
            shrink_window(NewState, S, T, LenS, LenT);
        false ->
            NewState = {Map, RequiredChars, CurrentChars, Left + 1, Right, MinLen, MinLeft, MinRight},
            shrink_window(NewState, S, T, LenS, LenT)
    end.

substring(S, Start, End) ->
    lists:sublist(S, Start, End - Start + 1).