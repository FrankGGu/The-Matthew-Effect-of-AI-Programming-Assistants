-spec can_convert_string(S :: unicode:unicode_binary(), T :: unicode:unicode_binary(), K :: integer()) -> boolean().
can_convert_string(S, T, K) when byte_size(S) =/= byte_size(T) -> false;
can_convert_string(S, T, K) ->
    Counts = lists:foldl(fun({A, B}, Acc) ->
                            Diff = (B - A) rem 26,
                            case Diff of
                                0 -> Acc;
                                _ -> maps:update_with(Diff, fun(V) -> V + 1 end, 1, Acc)
                            end
                         end, #{}, lists:zip(binary_to_list(S), binary_to_list(T))),
    lists:all(fun({D, C}) -> (D + (C - 1) * 26) =< K end, maps:to_list(Counts)).