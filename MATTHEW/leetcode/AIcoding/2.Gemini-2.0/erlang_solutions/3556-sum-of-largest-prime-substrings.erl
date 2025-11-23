-module(sum_largest_prime_substrings).
-export([solve/1]).

solve(S) ->
    solve(S, 0).

solve("", Acc) ->
    Acc;
solve(S, Acc) ->
    {LargestPrime, Rest} = find_largest_prime_substring(S),
    solve(Rest, Acc + LargestPrime).

find_largest_prime_substring(S) ->
    Len = length(S),
    find_largest_prime_substring(S, Len, 0).

find_largest_prime_substring(S, 0, Largest) ->
    {Largest, S};
find_largest_prime_substring(S, I, Largest) ->
    Sub = string:sub(S, 1, I),
    try
        Num = list_to_integer(string:to_list(Sub)),
        if is_prime(Num) ->
            {Num, string:sub(S, I + 1, length(S) - I)};
        true ->
            find_largest_prime_substring(S, I - 1, Largest)
        end
    catch
        _:_ ->
            find_largest_prime_substring(S, I - 1, Largest)
    end.

is_prime(N) when N < 2 ->
    false;
is_prime(N) ->
    is_prime(N, 2).

is_prime(N, I) when I * I > N ->
    true;
is_prime(N, I) when N rem I == 0 ->
    false;
is_prime(N, I) ->
    is_prime(N, I + 1).