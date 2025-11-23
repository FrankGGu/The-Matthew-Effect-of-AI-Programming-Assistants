-spec count_substrings(S :: unicode:unicode_binary()) -> integer().
count_substrings(S) ->
    Str = binary_to_list(S),
    Len = length(Str),
    Count = 0,
    lists:foldl(
        fun(I, Acc) ->
            lists:foldl(
                fun(J, InnerAcc) ->
                    Sub = lists:sublist(Str, I, J - I + 1),
                    Num = list_to_integer(Sub),
                    LastDigit = Num rem 10,
                    if
                        LastDigit =/= 0 andalso Num rem LastDigit =:= 0 -> InnerAcc + 1;
                        true -> InnerAcc
                    end
                end,
                Acc,
                lists:seq(I, Len)
        end,
        Count,
        lists:seq(1, Len)).