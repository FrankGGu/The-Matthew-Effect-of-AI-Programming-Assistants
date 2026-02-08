-spec count_good_triplets(Arr :: [integer()], A :: integer(), B :: integer(), C :: integer()) -> integer().
count_good_triplets(Arr, A, B, C) ->
    N = length(Arr),
    count(Arr, A, B, C, N, 0, 1, 2, 0).

count(_Arr, _A, _B, _C, N, I, J, K, Acc) when I >= N - 2 -> Acc;
count(Arr, A, B, C, N, I, J, K, Acc) when J >= N - 1 ->
    count(Arr, A, B, C, N, I + 1, I + 2, I + 3, Acc);
count(Arr, A, B, C, N, I, J, K, Acc) when K >= N ->
    count(Arr, A, B, C, N, I, J + 1, J + 2, Acc);
count(Arr, A, B, C, N, I, J, K, Acc) ->
    Vi = lists:nth(I + 1, Arr),
    Vj = lists:nth(J + 1, Arr),
    Vk = lists:nth(K + 1, Arr),
    case (abs(Vi - Vj) =< A andalso (abs(Vj - Vk)) =< B andalso (abs(Vi - Vk)) =< C of
        true -> count(Arr, A, B, C, N, I, J, K + 1, Acc + 1);
        false -> count(Arr, A, B, C, N, I, J, K + 1, Acc)
    end.