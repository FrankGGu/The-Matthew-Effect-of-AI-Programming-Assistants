-module(solution).
-export([can_split/1]).

is_increasing([]) -> true;
is_increasing([_]) -> true;
is_increasing([H1, H2 | T]) ->
    H1 < H2 andalso is_increasing([H2 | T]).

can_split(List) ->
    Len = length(List),
    can_split_loop(List, 1, Len - 1).

can_split_loop(_List, K, MaxK) when K > MaxK ->
    false;
can_split_loop(List, K, MaxK) ->
    {Left, Right} = lists:split(K, List),
    is_increasing(Left) andalso is_increasing(Right) orelse can_split_loop(List, K + 1, MaxK).