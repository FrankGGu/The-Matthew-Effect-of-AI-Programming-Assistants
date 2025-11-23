-module(solution).
-export([is_balanced/1]).

is_balanced(Root) ->
    case is_balanced_helper(Root) of
        {true, _} -> true;
        false -> false
    end.

is_balanced_helper(nil) -> {true, 0};
is_balanced_helper({Node, Left, Right}) ->
    {LeftBalanced, LeftHeight} = is_balanced_helper(Left),
    {RightBalanced, RightHeight} = is_balanced_helper(Right),
    Balanced = LeftBalanced andalso RightBalanced andalso abs(LeftHeight - RightHeight) =< 1,
    {Balanced, 1 + max(LeftHeight, RightHeight)}.

max(A, B) -> if A > B -> A; true -> B end.