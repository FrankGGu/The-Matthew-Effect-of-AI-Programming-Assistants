-module(solution).
-export([num_of_ways/2]).

num_of_ways(N, K) when K > N -> 0;
num_of_ways(N, K) -> 
    M = 1000000007,
    factorial(N) * mod_inverse(factorial(K) * factorial(N - K)) rem M.

factorial(0) -> 1;
factorial(N) -> N * factorial(N - 1) rem 1000000007.

mod_inverse(X) -> 
    pow(X, 1000000005, 1000000007).

pow(_, 0, _) -> 1;
pow(Base, Exp, Mod) -> 
    case Exp rem 2 of
        0 -> (pow(Base * Base rem Mod, Exp div 2, Mod) rem Mod);
        _ -> (Base * pow(Base, Exp - 1, Mod) rem Mod)
    end.