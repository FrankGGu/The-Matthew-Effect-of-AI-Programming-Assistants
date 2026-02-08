-module(solution).
-export([find_maximum_removals/3]).

-spec find_maximum_removals(S :: string(), P :: string(), Removals :: [integer()]) -> integer().
find_maximum_removals(S, P, Removals) ->
    LenRemovals = length(Removals),
    binary_search(S, P, Removals, 0, LenRemovals, 0).

binary_search(_S, _P, _Removals, Low, High, Ans) when Low > High ->
    Ans;
binary_search(S, P, Removals, Low, High, Ans) ->
    Mid = Low + (High - Low) div 2,
    if
        check(S, P, Removals, Mid) ->
            %% If P is a subsequence with Mid removals, try removing more (search right)
            binary_search(S, P, Removals, Mid + 1, High, Mid);
        true ->
            %% If P is not a subsequence, we removed too many (search left)
            binary_search(S, P, Removals, Low, Mid - 1, Ans)
    end.

check(S, P, Removals, K) ->
    %% Get the first K removal indices (0-indexed)
    RemovedIndices = lists:sublist(Removals, K),
    %% Convert to a gb_set for efficient O(log K) lookup
    RemovedSet = gb_sets:from_list(RemovedIndices),

    %% Build the modified S string by filtering out characters at removed indices
    S_prime = build_s_prime(S, 0, RemovedSet, []),

    %% Check if P is a subsequence of the modified S_prime
    is_subsequence(S_prime, P).

build_s_prime([], _Idx, _RemovedSet, Acc) ->
    lists:reverse(Acc);
build_s_prime([H | T], Idx, RemovedSet, Acc) ->
    if
        gb_sets:is_member(Idx, RemovedSet) ->
            %% Skip this character if its index is in the removed set
            build_s_prime(T, Idx + 1, RemovedSet, Acc);
        true ->
            %% Include this character
            build_s_prime(T, Idx + 1, RemovedSet, [H | Acc])
    end.

is_subsequence([], []) -> true;
is_subsequence(_Text, []) -> true; %% An empty pattern is always a subsequence of any text
is_subsequence([], _Pattern) -> false; %% A non-empty pattern cannot be a subsequence of an empty text
is_subsequence([H | T_Rest], [H | P_Rest]) ->
    %% Characters match, advance both text and pattern
    is_subsequence(T_Rest, P_Rest);
is_subsequence([_T_H | T_Rest], Pattern) ->
    %% Characters don't match, advance only text
    is_subsequence(T_Rest, Pattern).