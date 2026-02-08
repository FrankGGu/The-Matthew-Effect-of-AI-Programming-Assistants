-module(solution).
-export([minimumOperations/1]).

minimumOperations(Num) ->
    S = Num, % Num is already a string (list of chars)
    Len = length(S),

    Targets = [[$0,$0], [$2,$5], [$5,$0], [$7,$5]],

    % Initialize MinOps to a value greater than any possible valid answer.
    % Max length is 100, so max deletions for a valid two-digit suffix is 98 (e.g., "12...00").
    % Max deletions for "0" is 99 (e.g., "12...0").
    % So, 100 or 101 is a safe "infinity" value.
    InitialMinOps = 101, 

    MinOps = lists:foldl(fun(Target, AccMin) ->
        [X, Y] = Target,

        IdxY = find_char_right_to_left(S, Y, Len - 1),

        case IdxY of
            -1 -> AccMin; % Y not found
            _ ->
                IdxX = find_char_right_to_left(S, X, IdxY - 1),
                case IdxX of
                    -1 -> AccMin; % X not found to the left of Y
                    _ ->
                        % Deletions = (digits after Y) + (digits between X and Y)
                        % = (Len - 1 - IdxY) + (IdxY - 1 - IdxX)
                        % = Len - 2 - IdxX
                        Ops = Len - 2 - IdxX,
                        min(AccMin, Ops)
                end
        end
    end, InitialMinOps, Targets),

    % "A number is special if it is divisible by 25."
    % The number 0 is divisible by 25, so "0" is a special number.
    % If the input `Num` contains a '0', we can always delete all other digits
    % to form "0". This costs `Len - 1` operations.
    HasZero = lists:member($0, S),

    case HasZero of
        true -> min(MinOps, Len - 1);
        false -> MinOps
    end.

find_char_right_to_left(_S, _Char, Idx) when Idx < 0 -> -1;
find_char_right_to_left(S, Char, Idx) ->
    case lists:nth(Idx + 1, S) of % lists:nth is 1-indexed
        Char -> Idx;
        _ -> find_char_right_to_left(S, Char, Idx - 1)
    end.