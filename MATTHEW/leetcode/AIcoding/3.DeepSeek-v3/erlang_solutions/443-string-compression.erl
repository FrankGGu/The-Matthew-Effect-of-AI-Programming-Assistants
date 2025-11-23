-spec compress(Chars :: [char()]) -> integer().
compress(Chars) ->
    compress(Chars, [], 0, hd(Chars)).

compress([], Acc, Count, _Prev) ->
    Result = lists:reverse(Acc),
    length(Result);
compress([H|T], Acc, Count, Prev) when H =:= Prev ->
    compress(T, Acc, Count + 1, Prev);
compress([H|T], Acc, Count, Prev) ->
    NewAcc = case Count of
        1 -> [Prev | Acc];
        _ -> lists:reverse(integer_to_list(Count)) ++ [Prev | Acc]
    end,
    compress(T, NewAcc, 1, H).

compress([], Acc, Count, Prev) ->
    FinalAcc = case Count of
        1 -> [Prev | Acc];
        _ -> lists:reverse(integer_to_list(Count)) ++ [Prev | Acc]
    end,
    Result = lists:reverse(FinalAcc),
    length(Result).