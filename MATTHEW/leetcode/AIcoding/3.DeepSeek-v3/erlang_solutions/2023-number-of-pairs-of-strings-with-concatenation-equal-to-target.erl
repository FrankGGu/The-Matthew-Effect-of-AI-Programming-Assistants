-spec num_of_pairs(Words :: [unicode:unicode_binary()], Target :: unicode:unicode_binary()) -> integer().
num_of_pairs(Words, Target) ->
    Count = 0,
    Length = length(Words),
    lists:foldl(
        fun(I, Acc) ->
            lists:foldl(
                fun(J, InnerAcc) ->
                    case I =/= J andalso binary_to_list(lists:nth(I, Words)) ++ binary_to_list(lists:nth(J, Words)) =:= binary_to_list(Target) of
                        true -> InnerAcc + 1;
                        false -> InnerAcc
                    end
                end,
                Acc,
                lists:seq(1, Length)
            )
        end,
        Count,
        lists:seq(1, Length)
    ).