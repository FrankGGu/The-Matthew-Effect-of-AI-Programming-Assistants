-module(solution).
-export([longest_alternating_subarray/2]).

longest_alternating_subarray(Nums, Threshold) ->
    % Initial state:
    % MaxLen: The maximum length found so far (starts at 0).
    % CurrentLen: The length of the alternating subarray ending at the previous element (starts at 0, meaning no active subarray).
    % PrevParity: The parity of the last element in the current alternating subarray (irrelevant when CurrentLen is 0, so initialize to -1).
    solve(Nums, Threshold, 0, 0, -1).

solve([], _Threshold, MaxLen, _CurrentLen, _PrevParity) ->
    MaxLen;

solve([H|T], Threshold, MaxLen, 0, _PrevParity) when H =< Threshold andalso (H rem 2) == 0 ->
    % Start a new subarray of length 1. Update MaxLen if 1 is greater.
    solve(T, Threshold, max(MaxLen, 1), 1, H rem 2);

solve([_H|T], Threshold, MaxLen, 0, _PrevParity) ->
    % Continue searching for a starting element. CurrentLen remains 0.
    solve(T, Threshold, MaxLen, 0, -1); % PrevParity is irrelevant, can be -1

solve([H|T], Threshold, MaxLen, CurrentLen, PrevParity) when CurrentLen > 0 andalso H =< Threshold andalso (H rem 2) /= PrevParity ->
    % Extend the current subarray. Update MaxLen if the new length is greater.
    NewCurrentLen = CurrentLen + 1,
    solve(T, Threshold, max(MaxLen, NewCurrentLen), NewCurrentLen, H rem 2);

solve([H|T], Threshold, MaxLen, _CurrentLen, _PrevParity) when H =< Threshold andalso (H rem 2) == 0 ->
    % The old subarray is broken. Start a new one with H. Update MaxLen if 1 is greater.
    solve(T, Threshold, max(MaxLen, 1), 1, H rem 2);

solve([_H|T], Threshold, MaxLen, _CurrentLen, _PrevParity) ->
    % The old subarray is broken, and H cannot start a new one. Reset CurrentLen to 0.
    solve(T, Threshold, MaxLen, 0, -1).