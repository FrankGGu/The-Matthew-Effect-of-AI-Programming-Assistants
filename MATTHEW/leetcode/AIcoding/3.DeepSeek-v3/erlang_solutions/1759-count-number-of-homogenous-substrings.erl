-spec count_homogenous(S :: unicode:unicode_binary()) -> integer().
count_homogenous(S) ->
    {Ans, _, _} = lists:foldl(fun(Char, {Acc, Prev, Len}) ->
        case Char of
            Prev -> {Acc + Len + 1, Char, Len + 1};
            _ -> {Acc + 1, Char, 1}
        end
    end, {0, none, 0}, S),
    Ans rem 1000000007.