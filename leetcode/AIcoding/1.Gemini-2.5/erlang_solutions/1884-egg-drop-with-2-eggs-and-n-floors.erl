-module(solution).
-export([eggDrop/1]).

eggDrop(N) ->
    % The problem asks for the minimum number of moves (drops) 'x'
    % required to find the critical floor F, given 2 eggs and N floors.
    %
    % This is a classic dynamic programming problem that can be optimized
    % for the specific case of 2 eggs.
    %
    % Let 'x' be the number of drops. With 'x' drops and 2 eggs,
    % the maximum number of floors we can cover is given by the sum:
    % 1 + 2 + 3 + ... + x = x * (x + 1) / 2.
    %
    % We need to find the smallest integer 'x' such that the number of
    % floors we can cover is at least N:
    % x * (x + 1) / 2 >= N
    %
    % This inequality can be rewritten as a quadratic:
    % x^2 + x - 2N >= 0
    %
    % To find the minimum 'x', we can solve the corresponding equation
    % x^2 + x - 2N = 0 using the quadratic formula:
    % x = (-b +/- sqrt(b^2 - 4ac)) / 2a
    % For a=1, b=1, c=-2N:
    % x = (-1 +/- sqrt(1^2 - 4 * 1 * (-2N))) / (2 * 1)
    % x = (-1 +/- sqrt(1 + 8N)) / 2
    %
    % Since the number of drops 'x' must be positive, we take the positive root:
    % x = (-1 + sqrt(1 + 8N)) / 2
    %
    % The minimum integer number of drops will be the ceiling of this value.

    % Perform calculations using floating-point numbers to maintain precision.
    Val = (-1.0 + math:sqrt(1.0 + 8.0 * N)) / 2.0,

    % Take the ceiling of the result and convert it to an integer.
    trunc(math:ceil(Val)).