-module(solution).
-export([largestPalindrome/2]).

power10(N) ->
    power10(N, 1).

power10(0, Acc) -> Acc;
power10(N, Acc) -> power10(N - 1, Acc * 10).

reverse_digits(Num) ->
    reverse_digits(Num, 0).

reverse_digits(0, Rev) -> Rev;
reverse_digits(Num, Rev) ->
    reverse_digits(Num div 10, Rev * 10 + (Num rem 10)).

make_palindrome(FirstHalf, N) ->
    FirstHalf * power10(N) + reverse_digits(FirstHalf).

largestPalindrome(N, K) ->
    Modulo = 1337,

    if N == 1 ->
        %% For N=1, factors are 1-9. Products are 1-81.
        %% Palindromes among these products are 1, 2, ..., 9.
        %% All of these are products of two 1-digit numbers.
        %% We need the largest P in [1..9] such that P rem K == 0.
        find_largest_1_digit_palindrome(9, K) rem Modulo;
    true ->
        MaxFactor = power10(N) - 1, %% Largest N-digit number (e.g., 99 for N=2)
        MinFactor = power10(N - 1), %% Smallest N-digit number (e.g., 10 for N=2)

        %% Iterate `FirstHalf` from `MaxFactor` down to `MinFactor`.
        %% This generates 2N-digit palindromes in descending order.
        find_palindrome_product(MaxFactor, MaxFactor, MinFactor, K, Modulo, N)
    end.

find_largest_1_digit_palindrome(CurrentP, K) when CurrentP >= 1 ->
    if CurrentP rem K == 0 -> CurrentP;
       true -> find_largest_1_digit_palindrome(CurrentP - 1, K)
    end;
find_largest_1_digit_palindrome(_, _) -> 0. %% Should not be reached if a solution is guaranteed.

find_palindrome_product(FirstHalf, MaxFactor, MinFactor, K, Modulo, N) when FirstHalf >= MinFactor ->
    Palindrome = make_palindrome(FirstHalf, N),

    %% Calculate integer square root of Palindrome.
    SqrtPalindrome = round(math:sqrt(Palindrome)),

    %% Determine the starting and ending points for the inner factor-checking loop.
    %% `I_start`: The largest possible factor `i`. It cannot exceed `MaxFactor` or `SqrtPalindrome`.
    I_start = min(MaxFactor, SqrtPalindrome),

    %% `I_end`: The smallest possible factor `i`.
    %% `j = Palindrome div i`. `j` must be an N-digit number, so `j >= MinFactor`.
    %% This implies `Palindrome div i >= MinFactor`, or `i <= Palindrome div MinFactor`.
    %% Also, `i` itself must be an N-digit number, so `i >= MinFactor`.
    %% Combining these, `i` must be at least `max(MinFactor, Palindrome div MaxFactor)`.
    I_end = max(MinFactor, Palindrome div MaxFactor),

    %% Check if Palindrome can be factored into two N-digit numbers.
    Result = check_factors(I_start, I_end, MinFactor, Palindrome, K),

    if Result /= 0 -> %% Found a valid palindrome (largest one due to descending search)
        Result rem Modulo;
    true -> %% No factors found for this palindrome, try the next FirstHalf
        find_palindrome_product(FirstHalf - 1, MaxFactor, MinFactor, K, Modulo, N)
    end;
find_palindrome_product(_, _, _, _, _, _) ->
    0. %% Should not be reached if a solution is guaranteed.

check_factors(I, I_end, MinFactor, Palindrome, K) when I >= I_end ->
    if Palindrome rem I == 0 ->
        J = Palindrome div I,
        if J >= MinFactor -> %% `j` must be an N-digit number
            %% `I` is already guaranteed to be an N-digit number by its loop range (`I_start` to `I_end`).
            %% We don't need `J =< I` here. Since `I` starts from `min(MaxFactor, SqrtPalindrome)`
            %% and goes downwards, `J = Palindrome div I` will naturally be `>= I`.
            %% We just need to ensure `J` is an N-digit number.
            if Palindrome rem K == 0 ->
                Palindrome; %% Found a valid palindrome and it's divisible by K
            true ->
                check_factors(I - 1, I_end, MinFactor, Palindrome, K) %% Not divisible by K, try next factor `I`
            end;
        true ->
            check_factors(I - 1, I_end, MinFactor, Palindrome, K) %% `J` is not an N-digit number, try next factor `I`
        end;
    true ->
        check_factors(I - 1, I_end, MinFactor, Palindrome, K) %% `I` is not a factor, try next `I`
    end;
check_factors(_, _, _, _, _) ->
    0. %% No factors found for this palindrome.