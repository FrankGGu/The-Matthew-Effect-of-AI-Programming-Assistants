-spec digit_count(Num :: unicode:unicode_binary()) -> boolean().
digit_count(Num) ->
    Length = byte_size(Num),
    Counts = lists:foldl(fun(Char, Acc) ->
                             Index = Char - $0,
                             maps:update_with(Index, fun(V) -> V + 1 end, 1, Acc)
                         end, #{}, Num),
    lists:all(fun(I) ->
                  Char = binary:at(Num, I),
                  Expected = Char - $0,
                  maps:get(I, Counts, 0) =:= Expected
              end, lists:seq(0, Length - 1)).