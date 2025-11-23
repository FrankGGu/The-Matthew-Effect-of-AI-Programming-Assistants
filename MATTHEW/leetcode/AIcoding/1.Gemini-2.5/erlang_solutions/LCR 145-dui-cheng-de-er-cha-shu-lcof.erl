-module(solution).
-export([is_symmetric/1]).

is_symmetric(nil) -> true;
is_symmetric({_, Left, Right}) ->
    is_mirror(Left, Right).

is_mirror(nil, nil) -> true;
is_mirror(nil, _) -> false;
is_mirror(_, nil) -> false;
is_mirror({Val1, Left1, Right1}, {Val2, Left2, Right2}) ->
    Val1 == Val2 andalso
    is_mirror(Left1, Right2) andalso
    is_mirror(Right1, Left2).