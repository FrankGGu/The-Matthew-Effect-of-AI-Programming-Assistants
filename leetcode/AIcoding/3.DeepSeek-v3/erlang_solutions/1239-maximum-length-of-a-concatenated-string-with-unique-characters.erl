-spec max_length(L :: [unicode:unicode_binary()]) -> integer().
max_length(L) ->
    S = lists:filter(fun(S) -> length(S) == sets:size(sets:from_list(binary_to_list(S))) end, L),
    Max = lists:foldl(fun(S, Acc) -> 
        Bin = binary_to_list(S),
        Set = sets:from_list(Bin),
        lists:foldl(fun({Mask, Len}, Acc1) ->
            case (Mask band sets:foldl(fun(C, M) -> M bor (1 bsl (C - $a)) end, 0, Set)) of
                0 ->
                    NewMask = Mask bor sets:foldl(fun(C, M) -> M bor (1 bsl (C - $a)) end, 0, Set),
                    NewLen = Len + length(Bin),
                    [{NewMask, NewLen} | Acc1];
                _ ->
                    Acc1
            end
        end, Acc, Acc)
    end, [{0, 0}], S),
    lists:foldl(fun({_, Len}, Acc) -> max(Len, Acc) end, 0, Max).