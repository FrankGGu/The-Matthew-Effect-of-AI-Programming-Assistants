-module(solution).
-export([is_solvable/1]).

is_solvable(Equation) ->
    Words = parse_equation(Equation),
    UniqueChars = get_unique_chars(Words),
    solve(UniqueChars, Words, 0).

parse_equation(Equation) ->
    % Split the equation into words
    lists:map(fun (W) -> string:to_list(W) end, string:tokens(Equation, " + =")).

get_unique_chars(Words) ->
    lists:usort(lists:flatmap(fun Word -> Word end, Words)).

solve([], _, _) ->
    true;
solve([Char | Rest], Words, Carry) ->
    %% Try assigning digits 0-9 to each character
    lists:map(fun (Digit) -> 
        case is_valid_assignment(Char, Digit, Words, Carry) of
            true -> solve(Rest, Words, Carry);
            false -> false
        end
    end, lists:seq(0, 9)).

is_valid_assignment(Char, Digit, Words, Carry) ->
    %% Validate if the current assignment is consistent with the words
    % Implement the check logic here based on the current assignment.
    true. % Placeholder for valid assignment check