-module(solution).
-export([check_digits_equal/1]).

check_digits_equal(S) ->
    DigitsList = [C - $0 || C <- S],
    N = length(DigitsList),
    DigitsArray = array:from_list(DigitsList),
    check(0, DigitsArray, N).

check(I, DigitsArray, N) when I < N - 1 ->
    CurrentDigit = array:get(I, DigitsArray),
    case CurrentDigit of
        0 ->
            check(I + 1, DigitsArray, N);
        _ ->
            NextDigit = array:get(I + 1, DigitsArray),
            NewVal = (CurrentDigit + NextDigit) rem 10,
            case NewVal of
                0 ->
                    UpdatedArray = array:set(I, 0, DigitsArray),
                    UpdatedArray2 = array:set(I + 1, 0, UpdatedArray),
                    check(I + 1, UpdatedArray2, N);
                _ ->
                    false
            end
    end;
check(I, DigitsArray, N) when I == N - 1 ->
    array:get(I, DigitsArray) == 0;
check(_, _, _) ->
    true.