-spec balanced_string(S :: unicode:unicode_binary()) -> integer().
balanced_string(S) ->
    Count = maps:from_list([{C, 0} || C <- "QWER"]),
    Count1 = lists:foldl(fun(C, Acc) -> maps:update_with(C, fun(V) -> V + 1 end, Acc) end, Count, binary_to_list(S)),
    N = byte_size(S),
    Target = N div 4,
    Extra = maps:filter(fun(_, V) -> V > Target end, Count1),
    case maps:size(Extra) of
        0 -> 0;
        _ ->
            Left = 0,
            Right = 0,
            MinLen = N,
            Count2 = maps:from_list([{C, 0} || C <- "QWER"]),
            {MinLen1, _, _} = sliding_window(S, Left, Right, MinLen, Count2, Extra, Target),
            MinLen1
    end.

sliding_window(S, Left, Right, MinLen, Count, Extra, Target) ->
    N = byte_size(S),
    if
        Right >= N ->
            {MinLen, Left, Right};
        true ->
            C = binary:at(S, Right),
            Count1 = maps:update_with(C, fun(V) -> V + 1 end, Count),
            case is_valid(Count1, Extra, Target) of
                true ->
                    NewMinLen = min(MinLen, Right - Left + 1),
                    C1 = binary:at(S, Left),
                    Count2 = maps:update_with(C1, fun(V) -> V - 1 end, Count1),
                    sliding_window(S, Left + 1, Right, NewMinLen, Count2, Extra, Target);
                false ->
                    sliding_window(S, Left, Right + 1, MinLen, Count1, Extra, Target)
            end
    end.

is_valid(Count, Extra, Target) ->
    maps:fold(fun(K, V, Acc) ->
        case maps:get(K, Extra, 0) of
            0 -> Acc;
            Needed -> Acc andalso (maps:get(K, Count, 0) >= Needed
        end
    end, true, Extra).