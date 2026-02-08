-module(solution).
-export([divide_players/1]).

divide_players(Skill) ->
    SortedSkills = lists:sort(Skill),
    N = length(SortedSkills),

    % As per problem constraints, N is an even integer between 2 and 10^5.
    % So SortedSkills will never be empty, and N div 2 will be at least 1.
    TargetSum = hd(SortedSkills) + lists:last(SortedSkills),

    % Use two lists (original sorted and reversed sorted) to simulate two pointers
    % moving inwards from both ends of the original sorted list.
    % PairsToMake tracks how many pairs are left to form.
    divide_players_iter(SortedSkills, lists:reverse(SortedSkills), TargetSum, 0, N div 2).

divide_players_iter([], [], _TargetSum, AccChemistry, 0) ->
    AccChemistry;

divide_players_iter([LHead | LTail], [RHead | RTail], TargetSum, AccChemistry, PairsToMake) when PairsToMake > 0 ->
    if
        % Check if the sum of the current pair equals the target sum.
        LHead + RHead == TargetSum ->
            % If yes, add the product to the accumulated chemistry and recurse with the remaining lists.
            NewChemistry = AccChemistry + LHead * RHead,
            divide_players_iter(LTail, RTail, TargetSum, NewChemistry, PairsToMake - 1);
        true ->
            % If no, it's impossible to form teams with equal skill sum.
            -1
    end;

divide_players_iter(_, _, _, _, _) ->
    -1.