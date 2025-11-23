-spec check_almost_equivalent(Word1 :: unicode:unicode_binary(), Word2 :: unicode:unicode_binary()) -> boolean().
check_almost_equivalent(Word1, Word2) ->
    Count1 = count_chars(Word1),
    Count2 = count_chars(Word2),
    AllChars = lists:usort(maps:keys(Count1) ++ maps:keys(Count2)),
    lists:all(fun(Char) ->
                  AbsDiff = abs(maps:get(Char, Count1, 0) - maps:get(Char, Count2, 0)),
                  AbsDiff =< 3
              end, AllChars).

count_chars(Word) ->
    count_chars(Word, #{}).

count_chars(<<>>, Acc) -> Acc;
count_chars(<<Char/utf8, Rest/binary>>, Acc) ->
    NewAcc = maps:update_with(Char, fun(V) -> V + 1 end, 1, Acc),
    count_chars(Rest, NewAcc).