-spec get_permutation(N :: integer(), K :: integer()) -> unicode:unicode_binary().
get_permutation(N, K) ->
    Numbers = lists:seq(1, N),
    Fact = lists:foldl(fun(X, Acc) -> Acc * X end, 1, lists:seq(1, N)),
    get_permutation(N, K - 1, Numbers, Fact, []).

get_permutation(0, _, _, _, Acc) ->
    list_to_binary(lists:concat(lists:reverse(Acc)));
get_permutation(N, K, Numbers, Fact, Acc) ->
    GroupSize = Fact div N,
    Index = K div GroupSize,
    Selected = lists:nth(Index + 1, Numbers),
    NewNumbers = lists:delete(Selected, Numbers),
    NewFact = GroupSize,
    NewK = K rem GroupSize,
    get_permutation(N - 1, NewK, NewNumbers, NewFact, [Selected | Acc]).