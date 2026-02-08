-module(solution).
-export([sumOfEncryptedInt/1]).

-spec encrypt(N :: integer()) -> integer().
encrypt(N) ->
    {MaxDigit, NumDigits} = find_max_digit_and_count(N, 0, 0),
    build_encrypted_number(MaxDigit, NumDigits, 0).

-spec find_max_digit_and_count(N :: integer(), MaxDigitAcc :: integer(), NumDigitsAcc :: integer()) -> {integer(), integer()}.
find_max_digit_and_count(0, MaxDigitAcc, NumDigitsAcc) ->
    {MaxDigitAcc, NumDigitsAcc};
find_max_digit_and_count(N, MaxDigitAcc, NumDigitsAcc) ->
    Digit = N rem 10,
    NewMaxDigitAcc = max(MaxDigitAcc, Digit),
    NewNumDigitsAcc = NumDigitsAcc + 1,
    find_max_digit_and_count(N div 10, NewMaxDigitAcc, NewNumDigitsAcc).

-spec build_encrypted_number(MaxDigit :: integer(), NumDigitsLeft :: integer(), EncryptedAcc :: integer()) -> integer().
build_encrypted_number(_MaxDigit, 0, EncryptedAcc) ->
    EncryptedAcc;
build_encrypted_number(MaxDigit, NumDigitsLeft, EncryptedAcc) ->
    NewEncryptedAcc = EncryptedAcc * 10 + MaxDigit,
    build_encrypted_number(MaxDigit, NumDigitsLeft - 1, NewEncryptedAcc).

-spec sumOfEncryptedInt(Nums :: [integer()]) -> integer().
sumOfEncryptedInt(Nums) ->
    lists:sum(lists:map(fun encrypt/1, Nums)).