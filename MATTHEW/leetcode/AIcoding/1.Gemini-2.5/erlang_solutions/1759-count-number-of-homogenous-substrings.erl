-module(solution).
-export([countHomogenous/1]).

-define(MOD, 1000000007).

countHomogenous(S) ->
    % Initial call: S is the input string, 0 is the accumulated total count.
    % 0 is used as a placeholder for the initial CurrentChar (any value not matching 'a'-'z').
    % 0 is the initial CurrentBlockLength.
    solve(S, 0, 0, 0).

solve([], TotalCount, _CurrentChar, CurrentBlockLength) ->
    % Base case: End of string.
    % Calculate contribution from the last block of identical characters.
    BlockContribution = (CurrentBlockLength * (CurrentBlockLength + 1) div 2) rem ?MOD,
    (TotalCount + BlockContribution) rem ?MOD;
solve([H | T], TotalCount, CurrentChar, CurrentBlockLength) when H == CurrentChar ->
    % Current character is the same as the previous one, extend the block.
    solve(T, TotalCount, CurrentChar, CurrentBlockLength + 1);
solve([H | T], TotalCount, _CurrentChar, CurrentBlockLength) ->
    % Current character is different from the previous one, or it's the first character.
    % Calculate contribution from the completed block (if CurrentBlockLength > 0).
    BlockContribution = (CurrentBlockLength * (CurrentBlockLength + 1) div 2) rem ?MOD,
    NewTotalCount = (TotalCount + BlockContribution) rem ?MOD,
    % Start a new block with the current character.
    solve(T, NewTotalCount, H, 1).