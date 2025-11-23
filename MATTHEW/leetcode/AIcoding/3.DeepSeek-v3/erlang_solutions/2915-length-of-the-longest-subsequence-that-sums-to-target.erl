-spec length_of_longest_subsequence(Nums :: [integer()], Target :: integer()) -> integer().
length_of_longest_subsequence(Nums, Target) ->
    DP = maps:from_list([{0, 0}]),
    lists:foldl(fun(Num, Acc) ->
        maps:fold(fun(Sum, Len, InnerAcc) ->
            NewSum = Sum + Num,
            case NewSum =< Target of
                true ->
                    case maps:get(NewSum, InnerAcc, -1) of
                        -1 -> maps:put(NewSum, Len + 1, InnerAcc);
                        ExistingLen when Len + 1 > ExistingLen -> maps:put(NewSum, Len + 1, InnerAcc);
                        _ -> InnerAcc
                    end;
                false -> InnerAcc
            end
        end, Acc, Acc)
    end, DP, Nums),
    case maps:get(Target, DP, -1) of
        -1 -> -1;
        Len -> Len
    end.