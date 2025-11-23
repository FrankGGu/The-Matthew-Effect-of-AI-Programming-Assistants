-module(solution).
-export([min_window/2]).

min_window(Chars, K) ->
    Len = length(Chars),
    if
        K > Len -> "";
        true ->
            Map = maps:new(),
            Left = 0,
            Right = 0,
            Count = 0,
            MinLen = Len + 1,
            Result = "",
            loop(Chars, Map, Left, Right, Count, MinLen, Result, K)
    end.

loop(Chars, Map, Left, Right, Count, MinLen, Result, K) ->
    if
        Right == length(Chars) ->
            Result;
        true ->
            Char = lists:nth(Right + 1, Chars),
            NewMap = maps:update_with(Char, fun(V) -> V + 1 end, 1, Map),
            case maps:get(Char, NewMap) of
                1 -> Count1 = Count + 1;
                _ -> Count1 = Count
            end,
            while_count(Chars, NewMap, Left, Right, Count1, MinLen, Result, K)
    end.

while_count(Chars, Map, Left, Right, Count, MinLen, Result, K) ->
    if
        Count == K ->
            CurrentLen = Right - Left + 1,
            if
                CurrentLen < MinLen ->
                    Sub = lists:sublist(Chars, Left + 1, CurrentLen),
                    NewMinLen = CurrentLen,
                    NewResult = Sub,
                    NewLeft = Left + 1,
                    NewMap = maps:update_with(lists:nth(Left + 1, Chars), fun(V) -> V - 1 end, Map),
                    case maps:get(lists:nth(Left + 1, Chars), NewMap) of
                        0 -> NewCount = Count - 1;
                        _ -> NewCount = Count
                    end,
                    loop(Chars, NewMap, NewLeft, Right, NewCount, NewMinLen, NewResult, K);
                true ->
                    NewResult = Result,
                    NewMinLen = MinLen,
                    loop(Chars, Map, Left, Right + 1, Count, MinLen, Result, K)
            end;
        true ->
            loop(Chars, Map, Left, Right + 1, Count, MinLen, Result, K)
    end.