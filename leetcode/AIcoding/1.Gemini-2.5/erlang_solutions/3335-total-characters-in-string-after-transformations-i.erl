-module(solution).
-export([get_lucky/2]).

sum_digits_to_single_int(NumString) ->
    Sum = lists:foldl(fun(Char, Acc) -> Acc + (Char - $0) end, 0, NumString),
    if
        Sum < 10 -> Sum;
        true -> sum_digits_to_single_int(integer_to_list(Sum))
    end.

get_lucky(S, K) ->
    % Step 1: Replace each character with its 1-indexed alphabet position and concatenate.
    InitialTransformedString = lists:flatmap(fun(Char) ->
                                                 Val = Char - $a + 1,
                                                 integer_to_list(Val)
                                             end, S),

    % Step 2 & 3: Perform K transformations.
    % Each transformation involves summing digits until a single digit is obtained.
    % The result of this single-digit sum is then used as the input (converted back to string)
    % for the next transformation.
    perform_k_transformations(InitialTransformedString, K).

perform_k_transformations(CurrentString, 0) ->
    % When K is 0, we still need to apply the "sum until single digit" rule to the current string.
    % This handles the case where the initial string (after concatenation) might not be a single digit
    % and the problem requires the final output to be a single digit.
    sum_digits_to_single_int(CurrentString);

perform_k_transformations(CurrentString, K) when K > 0 ->
    % Perform one transformation: sum digits until a single-digit integer.
    SingleDigitInt = sum_digits_to_single_int(CurrentString),
    % For the next transformation, the input string is the string representation of this single digit.
    NextString = integer_to_list(SingleDigitInt),
    % Recurse for the remaining K-1 transformations.
    perform_k_transformations(NextString, K - 1).