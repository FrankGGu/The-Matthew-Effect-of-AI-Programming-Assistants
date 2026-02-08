-module(solution).
-export([min_window/2]).

min_window(Chars, K) ->
    Len = length(Chars),
    if
        Len < K -> "";
        true ->
            Count = maps:new(),
            Left = 0,
            Right = 0,
            MinLen = Len + 1,
            Result = "",
            do_window(Chars, K, Count, Left, Right, MinLen, Result)
    end.

do_window(_, _, _, _, _, MinLen, Result) when MinLen =< 0 ->
    Result;
do_window(Chars, K, Count, Left, Right, MinLen, Result) ->
    if
        Right >= length(Chars) ->
            Result;
        true ->
            Char = lists:nth(Right + 1, Chars),
            UpdatedCount = maps:update_with(Char, fun(V) -> V + 1 end, 1, Count),
            case maps:size(UpdatedCount) of
                _ when maps:is_key(Char, UpdatedCount) andalso maps:get(Char, UpdatedCount) >= K ->
                    NewMinLen = Right - Left + 1,
                    NewResult = if
                        NewMinLen < MinLen -> lists:sublist(Chars, Left + 1, NewMinLen);
                        true -> Result
                    end,
                    do_window(Chars, K, UpdatedCount, Left, Right + 1, NewMinLen, NewResult);
                _ ->
                    do_window(Chars, K, UpdatedCount, Left, Right + 1, MinLen, Result)
            end
    end.