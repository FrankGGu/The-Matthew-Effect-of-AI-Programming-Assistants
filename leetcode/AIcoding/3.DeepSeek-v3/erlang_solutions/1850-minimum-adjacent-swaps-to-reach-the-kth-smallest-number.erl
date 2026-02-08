-spec next_permutation(S :: unicode:unicode_binary(), K :: integer()) -> integer().
next_permutation(S, K) ->
    SList = binary_to_list(S),
    Perms = generate_kth_permutation(SList, K),
    count_swaps(SList, Perms).

generate_kth_permutation(S, K) ->
    Sorted = lists:sort(S),
    generate_kth_permutation(Sorted, K - 1, []).

generate_kth_permutation([H], 0, Acc) ->
    [H | Acc];
generate_kth_permutation(List, K, Acc) ->
    Len = length(List),
    Fact = factorial(Len - 1),
    Index = K div Fact,
    {Prefix, [H | Rest]} = lists:split(Index, List),
    generate_kth_permutation(Prefix ++ Rest, K rem Fact, [H | Acc]).

factorial(0) -> 1;
factorial(N) -> N * factorial(N - 1).

count_swaps(Original, Target) ->
    count_swaps(Original, Target, 0).

count_swaps([], [], Count) -> Count;
count_swaps([H | Original], [H | Target], Count) ->
    count_swaps(Original, Target, Count);
count_swaps(Original, [H | Target], Count) ->
    {Prefix, [H | Rest]} = lists:split(index_of(H, Original), Original),
    NewOriginal = Prefix ++ Rest,
    count_swaps(NewOriginal, Target, Count + length(Prefix)).

index_of(Item, List) -> index_of(Item, List, 0).

index_of(Item, [Item | _], Index) -> Index;
index_of(Item, [_ | Rest], Index) -> index_of(Item, Rest, Index + 1).