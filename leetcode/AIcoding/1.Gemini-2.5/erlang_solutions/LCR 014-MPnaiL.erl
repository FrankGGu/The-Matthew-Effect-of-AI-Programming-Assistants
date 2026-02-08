-module(solution).
-export([permute/1]).

-spec permute(list()) -> list(list()).
permute(List) when is_list(List) ->
    do_permute(List).

do_permute([]) ->
    [[]];
do_permute(List) ->
    %% For each element in the list, treat it as the first element of a permutation.
    %% Then, recursively find permutations of the remaining elements.
    %% 'lists:flatmap' is used to combine the results from all branches into a single list.
    lists:flatmap(
        fun(Index) ->
            %% Split the list at the current index to get the element and the remaining parts.
            %% lists:split(Index, List) returns {Prefix, [Element | Suffix]}.
            %% Note: lists:split is 0-indexed for the split point, but the second element of the tuple
            %% will be the list starting from the (Index+1)-th element.
            %% So, to get the element at 'Index' (0-based) and its prefix/suffix:
            {Prefix, [Char | Suffix]} = lists:split(Index, List),

            %% The 'Remaining' list is formed by concatenating the Prefix and Suffix.
            Remaining = Prefix ++ Suffix,

            %% Recursively find all permutations of the 'Remaining' list.
            %% For each such permutation 'P', prepend the current 'Char' to it.
            [ [Char | P] || P <- do_permute(Remaining) ]
        end,
        %% Iterate through all possible indices of the list.
        lists:seq(0, length(List) - 1)
    ).