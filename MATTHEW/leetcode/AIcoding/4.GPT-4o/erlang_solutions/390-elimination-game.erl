-module(solution).
-compile([export_all]).

% Main function to calculate the last remaining number
-spec last_remaining(N :: integer()) -> integer().
last_remaining(N) when N >= 1 ->
    last_remaining(N, true).

% Helper function to simulate the elimination process
last_remaining(1, _) -> 1;
last_remaining(N, LeftToRight) ->
    % Determine step direction and modify N accordingly
    if
        LeftToRight -> 
            last_remaining((N div 2), false); % Every other number is removed from left
        true -> 
            last_remaining(N - N div 2, true) % Every other number is removed from right
    end.
