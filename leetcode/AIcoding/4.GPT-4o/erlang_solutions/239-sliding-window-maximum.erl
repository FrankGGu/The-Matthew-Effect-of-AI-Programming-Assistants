-spec max_sliding_window(Nums :: [integer()], K :: integer()) -> [integer()].
max_sliding_window(Nums, K) ->
    max_sliding_window(Nums, K, [], []).

max_sliding_window([], _, _, Acc) -> lists:reverse(Acc);
max_sliding_window([Head | Tail], K, Window, Acc) ->
    NewWindow = update_window(Head, Window, K),
    case lists:reverse(NewWindow) of
        [Max | _] -> max_sliding_window(Tail, K, NewWindow, [Max | Acc]);
        [] -> max_sliding_window(Tail, K, NewWindow, Acc)
    end.

update_window(Head, Window, K) ->
    NewWindow = lists:filter(fun(X) -> X =/= Head end, Window),
    case length(NewWindow) >= K of
        true -> tl(NewWindow);
        false -> [Head | NewWindow]
    end.
