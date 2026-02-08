-module(solution).
-export([distinctNames/1]).

distinctNames(Ideas) ->
    % Step 1: Group suffixes by their first character.
    % Create a map where keys are first characters (integers 'a' through 'z')
    % and values are gb_sets of the remaining suffixes.
    CharToSuffixSets = lists:foldl(
        fun(Idea, Acc) ->
            case Idea of
                [Char | Suffix] ->
                    % Update the set for the current character.
                    % If the character is not yet in the map, create a new singleton set.
                    maps:update_with(Char, fun(Set) -> gb_sets:add(Suffix, Set) end, gb_sets:singleton(Suffix), Acc);
                _ -> % Empty string or non-list, should not occur based on constraints
                    Acc
            end
        end,
        maps:new(),
        Ideas
    ),

    % Step 2: Iterate through all unique pairs of distinct first characters (C1, C2).
    % For each pair, calculate the number of unique suffixes that appear only with C1
    % and only with C2, respectively.
    Count = lists:foldl(
        fun(C1, Acc1) ->
            % Get the set of suffixes for C1. If C1 has no associated ideas, Set1 will be empty.
            Set1 = maps:get(C1, CharToSuffixSets, gb_sets:new()),

            lists:foldl(
                fun(C2, Acc2) ->
                    % Get the set of suffixes for C2. If C2 has no associated ideas, Set2 will be empty.
                    Set2 = maps:get(C2, CharToSuffixSets, gb_sets:new()),

                    % Calculate the number of suffixes unique to Set1 (not in Set2).
                    NumS1Only = gb_sets:size(gb_sets:subtract(Set1, Set2)),

                    % Calculate the number of suffixes unique to Set2 (not in Set1).
                    NumS2Only = gb_sets:size(gb_sets:subtract(Set2, Set1)),

                    % Each combination of a unique suffix from Set1 and a unique suffix from Set2
                    % forms a good pair. Multiply by 2 because (idea1, idea2) and (idea2, idea1)
                    % are distinct pairs and both contribute to the total count.
                    Acc2 + NumS1Only * NumS2Only * 2
                end,
                Acc1,
                lists:seq(C1 + 1, $z) % Iterate C2 from C1 + 1 to 'z' to avoid duplicates and self-pairs
            )
        end,
        0,
        lists:seq($a, $y) % Iterate C1 from 'a' to 'y'
    ),

    Count.