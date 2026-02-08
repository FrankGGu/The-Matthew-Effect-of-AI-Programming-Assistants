-spec nth_super_ugly_number(N :: integer(), Primes :: [integer()]) -> integer().
nth_super_ugly_number(N, Primes) ->
    nth_super_ugly_number(N, Primes, [1], lists:duplicate(length(Primes), 1)).

nth_super_ugly_number(1, _, [UglyNumber | _], _) -> UglyNumber;
nth_super_ugly_number(N, Primes, [UglyNumber | RestUglyNumbers], Pointers) when N > 1 ->
    NextUgly = lists:min([lists:nth(P, RestUglyNumbers) * primes[P] || {P, primes} <- lists:zip([1,2,3], Primes)]),
    NewRest = [Ugly | Rest] = lists:filter(fun(X) -> X =/= NextUgly end, [UglyNumber | RestUglyNumbers]),
    nth_super_ugly_number(N - 1, Primes, [NextUgly | NewRest], [Pointers]).
