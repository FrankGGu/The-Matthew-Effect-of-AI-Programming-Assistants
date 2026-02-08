-spec digit_count(Num :: unicode:unicode_binary()) -> boolean().
digit_count(Num) ->
    Len = byte_size(Num),
    Counts = lists:foldl(fun(D, Acc) ->
                            Key = D - $0,
                            maps:update_with(Key, fun(V) -> V + 1 end, 1, Acc)
                         end, #{}, binary_to_list(Num)),
    lists:all(fun(I) ->
                 D = binary:at(Num, I) - $0,
                 case maps:get(I, Counts, 0) of
                     D -> true;
                     _ -> false
                 end
              end, lists:seq(0, Len - 1)).