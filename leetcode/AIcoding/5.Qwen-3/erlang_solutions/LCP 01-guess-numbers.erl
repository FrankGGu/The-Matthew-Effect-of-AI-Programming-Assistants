-module(guess_numbers).
-export([guessNumber/1]).

guessNumber(Num) ->
    guess(1, Num).

guess(Low, High) ->
    Mid = (Low + High) div 2,
    case feedback(Mid) of
        -1 -> guess(Low, Mid - 1);
        1 -> guess(Mid + 1, High);
        0 -> Mid
    end.

feedback(Guess) ->
    % This function is a placeholder to simulate the game's feedback.
    % In a real LeetCode environment, this would be provided by the system.
    % For testing purposes, you can replace this with actual logic.
    0.