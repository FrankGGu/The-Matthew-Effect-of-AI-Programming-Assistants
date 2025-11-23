-module(solution).
-export([findSecondMinimumValue/1]).

findSecondMinimumValue(Root) ->
    Min1 = element(1, Root), % Get the value of the root node
    Infinity = 1 bsl 31,     % A value larger than any possible node value (2^31)

    Result = dfs(Root, Min1, Infinity),

    case Result of
        Infinity -> -1; % If Infinity is still the result, no second minimum was found
        _ -> Result
    end.

dfs(nil, _, CurrentSecondMin) ->
    CurrentSecondMin;
dfs({Val, Left, Right}, Min1, CurrentSecondMin) ->
    if
        Val > Min1 ->
            % If the current node's value is greater than Min1,
            % it's a candidate for the second minimum.
            % We take the minimum of CurrentSecondMin and Val.
            % We don't need to traverse its children because due to the tree property
            % (parent.val = min(left.val, right.val)),
            % any child's value will be >= Val, so they cannot be a smaller second minimum.
            min(CurrentSecondMin, Val);
        true -> % Val == Min1
            % If the current node's value is equal to Min1,
            % we must traverse its children to find a potential second minimum.
            LeftSecondMin = dfs(Left, Min1, CurrentSecondMin),
            RightSecondMin = dfs(Right, Min1, CurrentSecondMin),
            min(LeftSecondMin, RightSecondMin)
    end.