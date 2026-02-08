-module(solution).
-export([sum_largest_prime_substrings/1]).

sum_largest_prime_substrings(S) ->
    N = length(S),
    MaxPrime = 0,
    lists:foldl(fun(I, Acc) ->
        lists:foldl(fun(J, Acc2) ->
            if J > I ->
                Sub = string:substr(S, I+1, J-I),
                Num = list_to_integer(Sub),
                case is_prime(Num) of
                    true when Num > Acc2 -> Num;
                    _ -> Acc2
                end;
            true -> Acc2
        end
    end, MaxPrime, lists:seq(0, N-1)), lists:seq(0, N-1)).

is_prime(2) -> true;
is_prime(N) when N < 2 -> false;
is_prime(N) ->
    is_prime(N, 2).

is_prime(N, Div) when Div * Div > N -> true;
is_prime(N, Div) ->
    case N rem Div of
        0 -> false;
        _ -> is_prime(N, Div + 1)
    end.