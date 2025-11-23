-module(solution).
-export([count_valid_paths/1]).

count_valid_paths(N, Edges) ->
    Primes = primes_up_to(N),
    Tree = build_tree(N, Edges),
    {Total, _} = dfs(1, -1, Tree, Primes, sets:new()),
    Total.

primes_up_to(N) ->
    Sieve = lists:duplicate(N + 1, true),
    Sieve1 = setelement(1, Sieve, false),
    Sieve2 = setelement(2, Sieve1, false),
    primes_up_to(2, N, Sieve2).

primes_up_to(P, N, Sieve) when P * P > N ->
    [X || X <- lists:seq(1, N), element(X, Sieve)];
primes_up_to(P, N, Sieve) ->
    case element(P, Sieve) of
        true ->
            Sieve1 = mark_multiples(P, P + P, N, Sieve),
            primes_up_to(P + 1, N, Sieve1);
        false ->
            primes_up_to(P + 1, N, Sieve)
    end.

mark_multiples(P, Current, N, Sieve) when Current > N ->
    Sieve;
mark_multiples(P, Current, N, Sieve) ->
    mark_multiples(P, Current + P, N, setelement(Current, Sieve, false)).

build_tree(N, Edges) ->
    Tree = maps:from_list([{X, []} || X <- lists:seq(1, N)]),
    lists:foldl(fun([U, V], Acc) ->
                    maps:update_with(U, fun(Neighs) -> [V | Neighs] end, Acc),
                    maps:update_with(V, fun(Neighs) -> [U | Neighs] end, Acc)
                end, Tree, Edges).

dfs(Node, Parent, Tree, Primes, Visited) ->
    IsPrime = element(Node, Primes),
    {Count, PrimeCount} = case IsPrime of
        true -> {0, 1};
        false -> {0, 0}
    end,
    lists:foldl(fun(Child, {Total, PrimesCnt}) ->
                    case Child =/= Parent of
                        true ->
                            {ChildTotal, ChildPrimes} = dfs(Child, Node, Tree, Primes, Visited),
                            NewTotal = Total + ChildTotal,
                            NewPrimesCnt = PrimesCnt + ChildPrimes,
                            case IsPrime of
                                true ->
                                    {NewTotal + ChildPrimes, NewPrimesCnt};
                                false ->
                                    {NewTotal, NewPrimesCnt}
                            end;
                        false ->
                            {Total, PrimesCnt}
                    end
                end, {Count, PrimeCount}, maps:get(Node, Tree)).