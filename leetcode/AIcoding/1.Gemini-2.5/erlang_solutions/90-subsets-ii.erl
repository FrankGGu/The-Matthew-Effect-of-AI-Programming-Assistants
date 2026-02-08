-module(solution).
-export([subsetsWithDup/1]).

subsetsWithDup(Nums) ->
    SortedNums = lists:sort(Nums),
    generate(SortedNums).

generate([]) ->
    [[]];
generate([H|T]) ->
    % Option 1: Generate subsets that do NOT include H (and its duplicates)
    % To avoid duplicate subsets, if we choose not to include H,
    % we must also skip all subsequent occurrences of H.
    NextUniqueT = skip_duplicates(T, H),
    SubsetsWithoutH = generate(NextUniqueT),

    % Option 2: Generate subsets that DO include H
    % For this, we consider H and then recursively generate subsets from the rest of the list (T).
    % Each subset generated from T will have H prepended.
    SubsetsWithH = lists:map(fun(S) -> [H|S] end, generate(T)),

    % Combine the two sets of subsets
    SubsetsWithH ++ SubsetsWithoutH.

skip_duplicates([], _Val) ->
    [];
skip_duplicates([H|T], Val) when H == Val ->
    skip_duplicates(T, Val);
skip_duplicates(List, _Val) ->
    List.