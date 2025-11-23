-module(solution).
-export([flipStringToMonotoneIncreasing/1]).

flipStringToMonotoneIncreasing(S) ->
    % The state of the fold is a tuple {Flips, Ones}.
    % Flips: Minimum number of flips required to make the prefix processed so far
    %        monotone increasing, assuming the current character (if it's '0')
    %        is either flipped to '1' or all preceding '1's are flipped to '0's.
    %        More precisely, 'Flips' represents the minimum cost to make the prefix
    %        monotone, where the split point (transition from 0s to 1s) is
    %        somewhere within or before the current position, and the current
    %        character is considered part of the '1's segment (or flipped to '1').
    % Ones:  Count of '1's encountered in the prefix processed so far.
    %        This is used to calculate the cost if the current '0' is kept as '0',
    %        implying all preceding '1's must be flipped to '0's.
    {MinFlips, _} = lists:foldl(fun(Char, {Flips, Ones}) ->
                                       case Char of
                                           $1 ->
                                               % If the current character is '1', it fits the '1's segment.
                                               % No additional flip cost for 'Flips'.
                                               % Increment the count of '1's.
                                               {Flips, Ones + 1};
                                           $0 ->
                                               % If the current character is '0':
                                               % Option 1: Flip this '0' to '1'.
                                               %           The cost is the previous 'Flips' plus 1.
                                               % Option 2: Keep this '0' as '0'.
                                               %           This implies all previous '1's must be flipped to '0's.
                                               %           The cost is 'Ones' (the count of '1's encountered so far).
                                               % We take the minimum of these two options for the new 'Flips'.
                                               % 'Ones' remains unchanged as this '0' does not contribute to the count of '1's.
                                               {min(Flips + 1, Ones), Ones}
                                       end
                               end, {0, 0}, S),
    MinFlips.