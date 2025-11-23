-module(guess_number).
-export([guess/1]).

guess(N) ->
    guess_number(1, N).

guess_number(Low, High) ->
    Mid = Low + (High - Low) div 2,
    case guess_api:guess(Mid) of
        -1 ->
            guess_number(Low, Mid - 1);
        1 ->
            guess_number(Mid + 1, High);
        0 ->
            Mid
    end.

-module(guess_api).
-export([guess/1]).

guess(Num) ->
    Secret = 6, % Replace with the actual secret number for testing
    case Num of
        Secret -> 0;
        _ when Num < Secret -> 1;
        _ -> -1
    end.