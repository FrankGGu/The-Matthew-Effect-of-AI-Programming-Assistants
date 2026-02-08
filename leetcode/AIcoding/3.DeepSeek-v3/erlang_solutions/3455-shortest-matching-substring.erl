-module(solution).
-export([min_window/2]).

min_window(S, T) ->
    SList = binary_to_list(S),
    TList = binary_to_list(T),
    case min_window_impl(SList, TList) of
        [] -> <<>>;
        Window -> list_to_binary(Window)
    end.

min_window_impl(S, T) ->
    TargetMap = build_char_map(T),
    TargetCount = maps:size(TargetMap),
    WindowMap = maps:new(),
    {Left, Right, Formed, MinLen, Result} = {0, 0, 0, length(S) + 1, []},
    scan_string(S, TargetMap, WindowMap, TargetCount, Left, Right, Formed, MinLen, Result).

build_char_map(Chars) ->
    lists:foldl(fun(Char, Map) ->
        maps:update_with(Char, fun(V) -> V + 1 end, 1, Map)
    end, maps:new(), Chars).

scan_string([], _, _, _, _, _, _, MinLen, Result) ->
    if MinLen =< length([]) + 1 -> Result;
       true -> []
    end;
scan_string([Char | Rest] = S, TargetMap, WindowMap, TargetCount, Left, Right, Formed, MinLen, Result) ->
    case maps:is_key(Char, TargetMap) of
        true ->
            NewWindowMap = maps:update_with(Char, fun(V) -> V + 1 end, 1, WindowMap),
            NewFormed = case maps:get(Char, NewWindowMap) =:= maps:get(Char, TargetMap) of
                true -> Formed + 1;
                false -> Formed
            end,
            {NewLeft, NewWindowMap1, NewFormed1, NewMinLen, NewResult} = 
                try_shrink(S, TargetMap, NewWindowMap, TargetCount, Left, Right + 1, NewFormed, MinLen, Result),
            scan_string(Rest, TargetMap, NewWindowMap1, TargetCount, NewLeft, Right + 1, NewFormed1, NewMinLen, NewResult);
        false ->
            scan_string(Rest, TargetMap, WindowMap, TargetCount, Left, Right + 1, Formed, MinLen, Result)
    end.

try_shrink(S, TargetMap, WindowMap, TargetCount, Left, Right, Formed, MinLen, Result) ->
    case Formed =:= TargetCount of
        true ->
            [Char | _] = lists:sublist(S, Left + 1, Right - Left),
            case maps:is_key(Char, TargetMap) of
                true ->
                    case maps:get(Char, WindowMap) =:= maps:get(Char, TargetMap) of
                        true ->
                            CurrentLen = Right - Left,
                            if CurrentLen < MinLen ->
                                NewResult = lists:sublist(S, Left + 1, CurrentLen),
                                NewMinLen = CurrentLen,
                                NewWindowMap = maps:update_with(Char, fun(V) -> V - 1 end, WindowMap),
                                NewFormed = Formed - 1,
                                try_shrink(S, TargetMap, NewWindowMap, TargetCount, Left + 1, Right, NewFormed, NewMinLen, NewResult);
                               true ->
                                NewWindowMap = maps:update_with(Char, fun(V) -> V - 1 end, WindowMap),
                                NewFormed = Formed - 1,
                                try_shrink(S, TargetMap, NewWindowMap, TargetCount, Left + 1, Right, NewFormed, MinLen, Result)
                            end;
                        false ->
                            NewWindowMap = maps:update_with(Char, fun(V) -> V - 1 end, WindowMap),
                            try_shrink(S, TargetMap, NewWindowMap, TargetCount, Left + 1, Right, Formed, MinLen, Result)
                    end;
                false ->
                    try_shrink(S, TargetMap, WindowMap, TargetCount, Left + 1, Right, Formed, MinLen, Result)
            end;
        false ->
            {Left, WindowMap, Formed, MinLen, Result}
    end.