-spec min_operations(Arr :: [integer()], K :: integer()) -> integer().
min_operations(Arr, K) ->
    N = length(Arr),
    Total = 0,
    lists:foldl(fun(I, Acc) ->
        Subsequence = lists:filter(fun(J) -> (J - 1) rem K =:= (I - 1) rem K end, lists:seq(1, N)),
        Subarray = [lists:nth(J, Arr) || J <- Subsequence],
        Length = length(Subarray),
        LIS = length(lis(Subarray)),
        Acc + (Length - LIS)
    end, Total, lists:seq(1, K)).

lis(List) ->
    Tails = lists:foldl(fun(X, Acc) ->
        case find_first_ge(Acc, X) of
            {found, Pos} -> 
                lists:sublist(Acc, Pos - 1) ++ [X] ++ lists:nthtail(Pos, Acc);
            not_found ->
                Acc ++ [X]
        end
    end, [], List),
    Tails.

find_first_ge([], _) -> not_found;
find_first_ge([H | T], X) when H >= X -> {found, 1};
find_first_ge([_ | T], X) ->
    case find_first_ge(T, X) of
        {found, Pos} -> {found, Pos + 1};
        not_found -> not_found
    end.