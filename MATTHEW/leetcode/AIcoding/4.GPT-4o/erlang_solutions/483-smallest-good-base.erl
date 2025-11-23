-module(solution).
-export([smallest_good_base/1]).

-spec smallest_good_base(unicode:unicode_binary()) -> unicode:unicode_binary().
smallest_good_base(N) ->
    % Convert string to integer
    IntN = list_to_integer(N),
    
    % Start binary search for the smallest base
    find_smallest_good_base(IntN, IntN).

% Binary search function to find the smallest good base
find_smallest_good_base(N, High) when High >= 2 ->
    Low = 2,
    Mid = (Low + High) div 2,
    
    % Check if base is valid
    case valid_base(Mid, N) of
        true -> 
            % If valid, check if smaller base exists
            find_smallest_good_base(N, Mid - 1);
        false -> 
            % Otherwise, check larger base
            find_smallest_good_base(N, High - 1)
    end.

find_smallest_good_base(_, 1) ->
    "1".

% Helper function to validate if a base is valid
valid_base(Base, N) ->
    % Iterate through powers of base
    validate_powers(Base, N, 0).

% Validate powers
validate_powers(Base, N, Sum) when Sum < N ->
    NewSum = Sum * Base + 1,
    validate_powers(Base, N, NewSum);

validate_powers(_, N, Sum) when Sum == N ->
    true;

validate_powers(_, _, _) ->
    false.
