-module(solution).
-compile([export_all]).

% Main function
integer_replacement(N) when N > 1 ->
    integer_replacement(N, 0).

% Base case: N = 1, no operations needed
integer_replacement(1, Count) -> Count;

% Recursive case for even numbers
integer_replacement(N, Count) when N rem 2 == 0 ->
    integer_replacement(N div 2, Count + 1);

% Recursive case for odd numbers
integer_replacement(N, Count) ->
    % Choose the best operation between N + 1 or N - 1
    MinCount = min(integer_replacement(N + 1, Count + 1), integer_replacement(N - 1, Count + 1)),
    MinCount.

% Helper function to compute the minimum of two numbers
min(A, B) when A < B -> A;
min(_, B) -> B.
