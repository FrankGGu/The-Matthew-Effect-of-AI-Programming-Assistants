-spec can_construct(S :: unicode:unicode_binary(), K :: integer()) -> boolean().
can_construct(S, K) ->
    Len = byte_size(S),
    if
        K > Len -> false;
        K =:= Len -> true;
        true ->
            Freq = lists:foldl(fun(Char, Acc) ->
                maps:update_with(Char, fun(V) -> V + 1 end, 1, Acc)
            end, #{}, binary_to_list(S)),
            OddCount = lists:foldl(fun({_, V}, Acc) ->
                if
                    V rem 2 =:= 1 -> Acc + 1;
                    true -> Acc
                end
            end, 0, maps:to_list(Freq)),
            OddCount =< K
    end.