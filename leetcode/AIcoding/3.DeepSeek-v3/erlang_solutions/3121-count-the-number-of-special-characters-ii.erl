-spec count_special_numbers(Word :: unicode:unicode_binary()) -> integer().
count_special_numbers(Word) ->
    Bin = unicode:characters_to_binary(Word),
    Freq = lists:foldl(fun(Char, Acc) ->
                           maps:update_with(Char, fun(V) -> V + 1 end, 1, Acc)
                       end, #{}, binary_to_list(Bin)),
    lists:foldl(fun(Char, Count) ->
                    Lower = string:to_lower(Char),
                    Upper = string:to_upper(Char),
                    case {maps:get(Lower, Freq, 0), maps:get(Upper, Freq, 0)} of
                        {LowerCnt, UpperCnt} when LowerCnt > 0, UpperCnt > 0 ->
                            Count + 1;
                        _ ->
                            Count
                    end
                end, 0, maps:keys(Freq)).