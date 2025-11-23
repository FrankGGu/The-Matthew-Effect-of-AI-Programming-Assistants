-spec pancake_sort(Arr :: [integer()]) -> [integer()].
pancake_sort(Arr) ->
    pancake_sort(Arr, length(Arr), []).

pancake_sort(_Arr, 1, Flips) ->
    Flips;
pancake_sort(Arr, N, Flips) ->
    MaxIndex = find_max_index(Arr, N),
    case MaxIndex of
        1 ->
            NewArr = flip(Arr, N),
            pancake_sort(NewArr, N - 1, [N | Flips]);
        N ->
            pancake_sort(Arr, N - 1, Flips);
        _ ->
            NewArr1 = flip(Arr, MaxIndex),
            NewArr2 = flip(NewArr1, N),
            pancake_sort(NewArr2, N - 1, [MaxIndex, N | Flips])
    end.

find_max_index(Arr, N) ->
    Max = lists:max(lists:sublist(Arr, N)),
    find_max_index(Arr, Max, 1).

find_max_index([H | _T], Max, Index) when H =:= Max ->
    Index;
find_max_index([_H | T], Max, Index) ->
    find_max_index(T, Max, Index + 1).

flip(Arr, K) ->
    {Prefix, Suffix} = lists:split(K, Arr),
    lists:reverse(Prefix) ++ Suffix.