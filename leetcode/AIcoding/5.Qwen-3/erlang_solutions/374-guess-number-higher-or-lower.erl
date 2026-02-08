-module(guess_number).
-export([guessNumber/1]).

guessNumber(N) ->
    guess(1, N).

guess(Low, High) ->
    Mid = (Low + High) div 2,
    case guess(Mid) of
        -1 -> guess(Low, Mid - 1);
        1 -> guess(Mid + 1, High);
        0 -> Mid
    end.

guess(N) ->
    % This is a mock function to simulate the LeetCode API.
    % In actual LeetCode submission, this function is provided by the platform.
    % For the purpose of this module, it's left as a placeholder.
    erlang:error("Function 'guess/1' is not implemented.");