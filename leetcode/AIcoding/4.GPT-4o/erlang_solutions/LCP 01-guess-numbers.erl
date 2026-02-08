-module(solution).
-export([guessNumber/2]).

guessNumber(N, Pick) ->
    guess(N, 1, N, Pick).

guess(Low, High, Pick) ->
    Guess = (Low + High) div 2,
    case guess(Guess) of
        0 -> Guess; 
        1 -> guess(Guess + 1, High, Pick); 
        -1 -> guess(Low, Guess - 1, Pick)
    end.

guess(Guess) ->
    %% This function should call the actual guess API in LeetCode.
    %% For example:
    %% if Guess < Pick -> 1;
    %% if Guess > Pick -> -1;
    %% if Guess == Pick -> 0;
    %% You will need to implement this based on the platform API.
    %% Placeholder return value (the user should implement this part):
    0.