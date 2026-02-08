-module(solution).
-export([atMostN/2]).

atMostN(D_str_list, N) ->
    % Convert D to a list of characters, sorted for easier comparison.
    % D_str_list is like ["1", "3", "5"], convert to ['1', '3', '5']
    D_chars = lists:sort([hd(S) || S <- D_str_list]),
    K = length(D_chars),

    % Convert N to a list of characters.
    N_chars = integer_to_list(N), % e.g., 100 -> "100" (list of chars)
    L = length(N_chars),

    % Step 1: Count numbers with fewer digits than N
    % These are numbers with 1, 2, ..., L-1 digits.
    % For each length `i`, there are K^i such numbers.
    CountFewerDigits = lists:sum([power(K, I) || I <- lists:seq(1, L - 1)]),

    % Step 2: Count numbers with L digits that are <= N
    CountLDigits = count_L_digits_recursive(N_chars, D_chars, K, L, 0, true),

    CountFewerDigits + CountLDigits.

power(_Base, 0) -> 1;
power(Base, Exp) when Exp > 0 -> Base * power(Base, Exp - 1).

count_L_digits_recursive([], _D_chars, _K, _TotalLength, _CurrentIndex, IsPrefixMatchPossible) ->
    % Base case: We have successfully processed all digits of N.
    % If IsPrefixMatchPossible is true, it means N itself can be formed.
    % Add 1 for N itself. Otherwise, we've already counted all numbers smaller than N.
    case IsPrefixMatchPossible of
        true -> 1;
        false -> 0
    end;
count_L_digits_recursive([N_head | N_tail], D_chars, K, TotalLength, CurrentIndex, IsPrefixMatchPossible) ->
    case IsPrefixMatchPossible of
        false ->
            % If at a previous position we couldn't match N's digit,
            % or we chose a smaller digit, then the current number is already
            % strictly smaller than N. For the remaining positions, any of the K digits
            % can be used.
            power(K, TotalLength - CurrentIndex);
        true ->
            % We are still trying to match N's prefix.
            SmallerCount = 0,
            FoundMatchAtCurrentPos = false,

            % Iterate through available digits D_char
            % Accumulate count for numbers that are strictly smaller than N at this position.
            % Also, check if N_head can be matched.
            {CurrentSmallerCount, CurrentFoundMatchAtCurrentPos} = lists:foldl(
                fun(D_char, {AccCount, AccFoundMatch}) ->
                    if
                        D_char < N_head ->
                            % If D_char is smaller than N_head, we can fill the remaining
                            % (TotalLength - 1 - CurrentIndex) positions with any of K digits.
                            {AccCount + power(K, TotalLength - 1 - CurrentIndex), AccFoundMatch};
                        D_char == N_head ->
                            % If D_char matches N_head, we can potentially continue matching N's prefix.
                            {AccCount, true};
                        true -> % D_char > N_head
                            % If D_char is greater than N_head, any further digits in D_chars
                            % will also be greater (since D_chars is sorted), so we stop considering them.
                            % This is effectively a 'break' in a foldl by returning the current accumulator.
                            {AccCount, AccFoundMatch}
                    end
                end,
                {SmallerCount, FoundMatchAtCurrentPos},
                D_chars
            ),

            % Recursively call for the next digit.
            % Add CurrentSmallerCount (numbers strictly smaller at this position)
            % to the result of the recursive call (numbers matching N's prefix or smaller later).
            count_L_digits_recursive(N_tail, D_chars, K, TotalLength, CurrentIndex + 1, CurrentFoundMatchAtCurrentPos) + CurrentSmallerCount
    end.