-module(solution).
-export([countBeautifulSubstrings/2]).

countBeautifulSubstrings(S, K) ->
    K_prime_factor_sqrt = calculate_K_prime_factor_sqrt(K),
    StringList = string:to_list(S),
    % State: (StringList, K_prime_factor_sqrt, CurrentVowels, CurrentConsonants, SeenCounts, Total)
    % SeenCounts: map where key is {Diff, VowelsModK_prime_factor_sqrt} and value is count
    % Initial state: Before index 0, 0 vowels, 0 consonants, diff 0, vowels mod K_prime_factor_sqrt 0.
    solve(StringList, K_prime_factor_sqrt, 0, 0, #{{0,0} => 1}, 0).

solve([], _, _, _, _, Total) -> Total;
solve([Char | Rest], K_prime_factor_sqrt, CurrentVowels, CurrentConsonants, SeenCounts, Total) ->
    {NewCurrentVowels, NewCurrentConsonants} =
        if is_vowel(Char) -> {CurrentVowels + 1, CurrentConsonants};
           true -> {CurrentVowels, CurrentConsonants + 1}
        end,

    CurrentDiff = NewCurrentVowels - NewCurrentConsonants,
    CurrentVowelsModK = NewCurrentVowels rem K_prime_factor_sqrt,

    Key = {CurrentDiff, CurrentVowelsModK},

    Count = maps:get(Key, SeenCounts, 0),
    NewTotal = Total + Count,

    NewSeenCounts = maps:update_with(Key, fun(V) -> V + 1 end, 1, SeenCounts),

    solve(Rest, K_prime_factor_sqrt, NewCurrentVowels, NewCurrentConsonants, NewSeenCounts, NewTotal).

is_vowel($a) -> true;
is_vowel($e) -> true;
is_vowel($i) -> true;
is_vowel($o) -> true;
is_vowel($u) -> true;
is_vowel(_) -> false.

calculate_K_prime_factor_sqrt(1) -> 1;
calculate_K_prime_factor_sqrt(K) ->
    Factors = prime_factorize(K),
    lists:foldl(fun({P, E}, Acc) -> Acc * pow(P, (E + 1) div 2) end, 1, Factors).

prime_factorize(N) when N < 1 -> [];
prime_factorize(1) -> [];
prime_factorize(N) ->
    prime_factorize_loop(N, 2, []).

prime_factorize_loop(1, _, Acc) -> lists:reverse(Acc);
prime_factorize_loop(N, D, Acc) when D * D > N -> lists:reverse([{N, 1} | Acc]);
prime_factorize_loop(N, D, Acc) ->
    case N rem D of
        0 ->
            {NewN, Count} = count_and_divide(N, D, 0),
            prime_factorize_loop(NewN, D + 1, [{D, Count} | Acc]);
        _ ->
            prime_factorize_loop(N, D + 1, Acc)
    end.

count_and_divide(N, D, Count) ->
    if N rem D == 0 -> count_and_divide(N div D, D, Count + 1);
       true -> {N, Count}
    end.

pow(Base, 0) -> 1;
pow(Base, 1) -> Base;
pow(Base, Exp) when Exp > 1 ->
    Half = pow(Base, Exp div 2),
    Result = Half * Half,
    if Exp rem 2 == 1 -> Result * Base;
       true -> Result
    end.