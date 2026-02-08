-spec maximum_requests(N :: integer(), Requests :: [[integer()]]) -> integer().
maximum_requests(N, Requests) ->
    Max = length(Requests),
    check_all_subsets(N, Requests, Max, Max).

check_all_subsets(_, _, 0, _) -> 0;
check_all_subsets(N, Requests, K, Max) ->
    case try_subsets(N, Requests, K, Max) of
        -1 -> check_all_subsets(N, Requests, K - 1, Max);
        Res -> Res
    end.

try_subsets(N, Requests, K, Max) ->
    Subsets = combinations(Requests, K),
    try_subsets(N, Subsets, K, Max, length(Subsets)).

try_subsets(_, _, _, _, 0) -> -1;
try_subsets(N, [Subset | Rest], K, Max, Len) ->
    case is_valid(N, Subset) of
        true -> K;
        false -> try_subsets(N, Rest, K, Max, Len - 1)
    end.

is_valid(N, Subset) ->
    Balance = lists:foldl(fun([From, To], Acc) ->
                              Acc1 = maps:update_with(From, fun(V) -> V - 1 end, Acc),
                              maps:update_with(To, fun(V) -> V + 1 end, Acc1)
                          end, maps:from_list([{I, 0} || I <- lists:seq(0, N - 1)]), Subset),
    lists:all(fun({_, V}) -> V =:= 0 end, maps:to_list(Balance)).

combinations(List, K) ->
    combinations(List, K, length(List)).

combinations(_, 0, _) -> [[]];
combinations([], _, _) -> [];
combinations([H | T], K, N) ->
    [[H | Comb] || Comb <- combinations(T, K - 1, N - 1)] ++
    combinations(T, K, N - 1).