-spec largest_number(Nums :: [integer()]) -> unicode:chardata().
largest_number(Nums) ->
    StringNums = [integer_to_list(N) || N <- Nums],

    SortedStrings = lists:sort(fun(A, B) -> (A ++ B) >= (B ++ A) end, StringNums),

    Result = lists:flatten(SortedStrings),

    case Result of
        [$$0|_] -> "0";
        _ -> Result
    end.