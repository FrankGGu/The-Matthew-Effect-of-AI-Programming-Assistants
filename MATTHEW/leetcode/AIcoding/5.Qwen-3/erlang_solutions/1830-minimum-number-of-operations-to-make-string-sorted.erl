-module(solution).
-export([min_operations_to_make_sorted/1]).

min_operations_to_make_sorted(S) ->
    N = length(S),
    Factorial = lists:seq(1, N),
    Fact = maps:from_list([{I, factorial(I)} || I <- Factorial]),
    InvFact = maps:from_list([{I, inv_factorial(Fact, I)} || I <- Factorial]),
    Count = lists:foldl(fun(C, Acc) -> maps:update_with(C, fun(V) -> V + 1 end, 1, Acc) end, #{}, S),
    Sorted = lists:usort(S),
    Result = 0,
    lists:foldl(fun(I, Acc) -> process_char(I, S, Sorted, Count, Fact, InvFact, Acc) end, Result, lists:seq(0, N-1)).

factorial(0) -> 1;
factorial(N) when N > 0 -> N * factorial(N-1).

inv_factorial(_, 0) -> 1;
inv_factorial(Fact, N) -> 1 div maps:get(N, Fact).

process_char(Index, S, Sorted, Count, Fact, InvFact, Acc) ->
    C = lists:nth(Index+1, S),
    SortedC = lists:nth(Index+1, Sorted),
    if
        C == SortedC ->
            Count2 = maps:update_with(C, fun(V) -> V - 1 end, Count),
            process_char(Index+1, S, Sorted, Count2, Fact, InvFact, Acc);
        true ->
            Remaining = maps:values(maps:filter(fun(K, V) -> V > 0 andalso K > C end, Count)),
            Total = lists:sum(Remaining),
            Count2 = maps:update_with(C, fun(V) -> V - 1 end, Count),
            Perms = perm_count(Count2, Fact),
            Acc + (Total * Perms) div (maps:get(1, Fact) // maps:get(1, Fact))
    end.

perm_count(Count, Fact) ->
    N = lists:sum(maps:values(Count)),
    Product = 1,
    lists:foldl(fun({K, V}, Acc) -> Acc * maps:get(V, Fact) end, Product, maps:to_list(Count)).

perm_count(_Count, _Fact) -> 1.