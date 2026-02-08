-module(closest_prime_numbers).
-export([closest_primes/2]).

closest_primes(L, R) ->
    Primes = generate_primes(L, R),
    case Primes of
        [] -> [-1, -1];
        [_] -> [-1, -1];
        _ -> find_closest(Primes)
    end.

generate_primes(L, R) ->
    lists:filter(fun(X) -> is_prime(X) end, lists:seq(L, R)).

is_prime(N) when N < 2 -> false;
is_prime(2) -> true;
is_prime(N) -> 
    not lists:any(fun(X) -> N rem X == 0 end, lists:seq(2, floor(math:sqrt(N)))).

find_closest(Primes) ->
    lists:foldl(fun(X, {Prev, Closest}) ->
        case Closest of
            {_, -1} -> {X, {X, -1}};
            {Last, _} -> 
                case X - Last of
                    _ when X - Last < Last - Prev -> {X, {X, Last}};
                    _ -> {Prev, {Prev, X}}
                end
        end
    end, {hd(Primes), {-1, -1}}, tl(Primes)).