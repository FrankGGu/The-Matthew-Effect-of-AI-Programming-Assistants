-module(solution).
-export([is_solvable/2]).

is_solvable(Words, Result) ->
    AllWords = Words ++ [Result],

    UniqueCharsList = lists:sort(lists:usort(lists:flatten(AllWords))),

    Coefficients = calculate_coefficients(Words, Result),

    LeadingChars = get_leading_chars(AllWords),

    solve(UniqueCharsList, Coefficients, LeadingChars, sets:new(), 0).

calculate_coefficients(Words, Result) ->
    InitialCoeffs = #{},
    Coeffs1 = lists:foldl(fun(Word, AccCoeffs) ->
                                 do_add_word_coeffs(Word, AccCoeffs, 1)
                         end, InitialCoeffs, Words),
    Coeffs2 = do_add_word_coeffs(Result, Coeffs1, -1),
    Coeffs2.

do_add_word_coeffs(Word, AccCoeffs, Sign) ->
    {_FinalPower, FinalCoeffs} = lists:foldl(fun(Char, {Power, CurrentCoeffs}) ->
                                                    Coeff = maps:get(Char, CurrentCoeffs, 0),
                                                    NewCoeffs = maps:put(Char, Coeff + Sign * Power, CurrentCoeffs),
                                                    {Power * 10, NewCoeffs}
                                            end, {1, AccCoeffs}, lists:reverse(Word)),
    FinalCoeffs.

get_leading_chars(AllWords) ->
    lists:foldl(fun([H|_T], AccSet) -> sets:add_element(H, AccSet) end, sets:new(), AllWords).

solve([], _Coefficients, _LeadingChars, _UsedDigits, CurrentSum) ->
    CurrentSum == 0;
solve([Char|RestChars], Coefficients, LeadingChars, UsedDigits, CurrentSum) ->
    IsLeading = sets:is_element(Char, LeadingChars),
    CharCoeff = maps:get(Char, Coefficients),

    lists:any(fun(Digit) ->
                      not sets:is_element(Digit, UsedDigits)
                      andalso
                      (not IsLeading orelse Digit /= 0)
                      andalso
                      solve(RestChars,
                            Coefficients,
                            LeadingChars,
                            sets:add_element(Digit, UsedDigits),
                            CurrentSum + CharCoeff * Digit)
              end, lists:seq(0, 9)).