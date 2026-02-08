-module(solution).
-export([shortestBeautifulSubstring/2]).

is_prime(N) when N < 2 -> false;
is_prime(2) -> true;
is_prime(3) -> true;
is_prime(N) when N rem 2 == 0 -> false;
is_prime(N) ->
    is_prime_check(N, 3).

is_prime_check(N, Divisor) when Divisor * Divisor > N -> true;
is_prime_check(N, Divisor) when N rem Divisor == 0 -> false;
is_prime_check(N, Divisor) ->
    is_prime_check(N, Divisor + 2).

shortestBeautifulSubstring(S, K) ->
    LenS = length(S),
    Candidates = find_candidates(S, K, LenS, 0, []),
    case Candidates of
        [] ->
            "";
        _ ->
            lists:sort(Candidates) |> hd
    end.

find_candidates(S, K, LenS, StartIdx, Acc) when StartIdx + K =< LenS ->
    Sub = string:substr(S, StartIdx + 1, K),
    NewAcc =
        case is_beautiful_candidate(Sub) of
            true ->
                [Sub | Acc];
            false ->
                Acc
        end,
    find_candidates(S, K, LenS, StartIdx + 1, NewAcc);
find_candidates(_S, _K, _LenS, _StartIdx, Acc) ->
    Acc.

is_beautiful_candidate(Sub) ->
    case hd(Sub) of
        $0 -> false;
        $1 ->
            Num = erlang:binary_to_integer(list_to_binary(Sub), 2),
            is_prime(Num)
    end.