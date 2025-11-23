-module(solution).
-export([subsets/1]).

subsets([]) ->
    [[]];
subsets([H|T]) ->
    % Recursively get all subsets of the tail (T)
    % These subsets do not include the current head (H)
    SubsetsWithoutH = subsets(T),

    % For each subset obtained from T, create a new subset by
    % prepending the current head (H) to it.
    % These subsets all include the current head (H)
    SubsetsWithH = lists:map(fun(S) -> [H|S] end, SubsetsWithoutH),

    % Combine both sets of subsets to get the complete list of subsets
    % for the current list [H|T]
    SubsetsWithoutH ++ SubsetsWithH.