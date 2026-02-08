-spec max_sum_of_three_subarrays(Nums :: [integer()], K :: integer()) -> [integer()].
max_sum_of_three_subarrays(Nums, K) ->
    N = length(Nums),
    Sums = lists:foldl(fun(X, Acc) -> [hd(Acc) + X | Acc] end, [0], Nums),
    SumsRev = lists:reverse(Sums),

    Left = array:new(N, [{default, 0}]),
    Left1 = lists:foldl(fun(I, Acc) ->
        case I - K + 1 >= 1 of
            true ->
                Sum = lists:nth(I + 1, SumsRev) - lists:nth(I - K + 1, SumsRev),
                Prev = array:get(I - 1, Acc),
                case Sum > array:get(Prev, Acc) of
                    true -> array:set(I, I - K + 1, Acc);
                    false -> array:set(I, Prev, Acc)
                end;
            false -> Acc
        end
    end, Left, lists:seq(1, N)),

    Right = array:new(N, [{default, 0}]),
    Right1 = lists:foldr(fun(I, Acc) ->
        case I + K - 1 =< N of
            true ->
                Sum = lists:nth(I + K, SumsRev) - lists:nth(I, SumsRev),
                Prev = array:get(I + 1, Acc),
                case Sum >= array:get(Prev, Acc) of
                    true -> array:set(I, I, Acc);
                    false -> array:set(I, Prev, Acc)
                end;
            false -> Acc
        end
    end, Right, lists:seq(1, N)),

    MaxSum = -1,
    Result = [0, 0, 0],

    {FinalMaxSum, FinalResult} = lists:foldl(fun(I, {CurrentMax, CurrentRes}) ->
        case I >= K + 1 andalso I + K =< N of
            true ->
                L = array:get(I - 1, Left1),
                R = array:get(I + K, Right1),
                Sum1 = lists:nth(L + K, SumsRev) - lists:nth(L, SumsRev),
                Sum2 = lists:nth(I + K, SumsRev) - lists:nth(I, SumsRev),
                Sum3 = lists:nth(R + K, SumsRev) - lists:nth(R, SumsRev),
                Total = Sum1 + Sum2 + Sum3,
                case Total > CurrentMax of
                    true -> {Total, [L, I, R]};
                    false -> {CurrentMax, CurrentRes}
                end;
            false -> {CurrentMax, CurrentRes}
        end
    end, {MaxSum, Result}, lists:seq(1, N)),

    FinalResult.