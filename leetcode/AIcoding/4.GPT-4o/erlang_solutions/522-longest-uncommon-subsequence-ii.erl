-module(solution).
-export([find_lu_slength/1]).

%% Find the length of the longest uncommon subsequence.
-spec find_lu_slength([string()]) -> integer().
find_lu_slength(Strs) ->
    find_lu_slength(Strs, length(Strs)).

%% Helper function that finds the longest uncommon subsequence length
-spec find_lu_slength([string()], integer()) -> integer().
find_lu_slength([H | T], N) when N > 1 ->
    case lists:all(fun(X) -> H == X end, T) of
        true -> find_lu_slength(T, N - 1); %% Skip if current string is present in all
        false -> max(length(H), find_lu_slength(T, N - 1)) %% Update if uncommon subsequence found
    end;
find_lu_slength([], _) -> -1. %% No uncommon subsequence found
find_lu_slength([_], _) -> -1. %% Only one string left, no uncommon subsequence can exist
find_lu_slength(_, _) -> -1. %% If no subsequence is found, return -1
