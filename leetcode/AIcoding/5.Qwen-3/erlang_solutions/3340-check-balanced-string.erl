-module(solution).
-export([is_balanced/1]).

is_balanced(S) ->
    is_balanced(S, 0).

is_balanced([], _Count) ->
    true;
is_balanced([H | T], Count) ->
    case H of
        $a -> is_balanced(T, Count + 1);
        $b -> is_balanced(T, Count - 1);
        _ -> false
    end.