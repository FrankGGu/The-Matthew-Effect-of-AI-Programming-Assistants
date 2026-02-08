-spec kth_palindrome(Queries :: [integer()], IntLength :: integer()) -> [integer()].
kth_palindrome(Queries, IntLength) ->
    HalfLength = (IntLength + 1) div 2,
    Start = trunc(math:pow(10, HalfLength - 1)),
    End = trunc(math:pow(10, HalfLength)) - 1,
    lists:map(fun(Q) ->
        K = Q - 1,
        if
            K >= 0 andalso (Start + K) =< End ->
                Prefix = Start + K,
                PrefixStr = integer_to_list(Prefix),
                SuffixStr = case IntLength rem 2 of
                                0 -> PrefixStr;
                                1 -> string:substr(PrefixStr, 1, length(PrefixStr) - 1)
                            end,
                list_to_integer(PrefixStr ++ lists:reverse(SuffixStr));
            true -> -1
        end
    end, Queries).