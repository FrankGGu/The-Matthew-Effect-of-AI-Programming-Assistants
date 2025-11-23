-module(min_window_substring).
-export([min_window/2]).

min_window(S, T) ->
    case length(T) of
        0 -> "";
        _ ->
            TMap = build_map(T),
            TLen = length(T),
            SLen = length(S),
            {_, _, Result} = do_min_window(S, SLen, TMap, TLen, 0, 0, 0, #{}),
            Result
    end.

build_map([]) -> #{};
build_map([C | Rest]) ->
    Map = build_map(Rest),
    Count = maps:get(C, Map, 0),
    maps:put(C, Count + 1, Map).

do_min_window(_, _, _, _, _, _, _, _) -> {0, 0, ""};
do_min_window(S, SLen, TMap, TLen, Left, Right, Count, Window) when Right >= SLen ->
    {Left, Right, ""};
do_min_window(S, SLen, TMap, TLen, Left, Right, Count, Window) ->
    CurrentChar = lists:nth(Right + 1, S),
    case maps:is_key(CurrentChar, TMap) of
        true ->
            NewCount = if Count == TLen -> Count; true -> Count + 1 end,
            NewWindow = maps:update(CurrentChar, maps:get(CurrentChar, Window, 0) + 1, Window),
            case NewCount == TLen of
                true ->
                    {NewLeft, NewRight, Result} = shrink_window(S, SLen, TMap, TLen, Left, Right, NewCount, NewWindow),
                    do_min_window(S, SLen, TMap, TLen, NewLeft, NewRight + 1, NewCount, NewWindow);
                false ->
                    do_min_window(S, SLen, TMap, TLen, Left, Right + 1, NewCount, NewWindow)
            end;
        false ->
            do_min_window(S, SLen, TMap, TLen, Left, Right + 1, Count, Window)
    end.

shrink_window(S, SLen, TMap, TLen, Left, Right, Count, Window) ->
    CurrentChar = lists:nth(Left + 1, S),
    case maps:is_key(CurrentChar, TMap) of
        true ->
            NewWindow = maps:update(CurrentChar, maps:get(CurrentChar, Window) - 1, Window),
            case maps:get(CurrentChar, NewWindow) < maps:get(CurrentChar, TMap) of
                true ->
                    NewCount = Count - 1,
                    {Left + 1, Right, get_result(S, Left, Right, CurrentChar, NewCount, NewWindow)};
                false ->
                    {Left + 1, Right, get_result(S, Left, Right, CurrentChar, Count, NewWindow)}
            end;
        false ->
            {Left + 1, Right, get_result(S, Left, Right, CurrentChar, Count, Window)}
    end.

get_result(S, Left, Right, _CurrentChar, Count, _Window) when Count == 0 ->
    Sub = lists:sublist(S, Left + 1, Right - Left),
    Sub;
get_result(S, Left, Right, _CurrentChar, _Count, _Window) ->
    Sub = lists:sublist(S, Left + 1, Right - Left),
    Sub.