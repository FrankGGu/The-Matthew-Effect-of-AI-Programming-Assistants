-spec last_remaining(N :: integer()) -> integer().
last_remaining(N) ->
    helper(N, left).

helper(1, _) -> 1;
helper(N, left) -> 2 * helper(N div 2, right);
helper(N, right) -> 
    case N rem 2 of
        0 -> 2 * helper(N div 2, left) - 1;
        1 -> 2 * helper(N div 2, left)
    end.