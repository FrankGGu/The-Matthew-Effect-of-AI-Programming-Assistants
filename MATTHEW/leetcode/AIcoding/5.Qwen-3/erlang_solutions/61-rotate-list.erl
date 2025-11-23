-module(rotate_list).
-export([rotate_right/2]).

rotate_right([], _) -> [];
rotate_right([H|T], 0) -> [H|T];
rotate_right(List, K) ->
    Len = length(List),
    K1 = K rem Len,
    rotate_right(List, K1, Len).

rotate_right(List, 0, _) -> List;
rotate_right(List, K, Len) ->
    {Left, Right} = lists:split(Len - K, List),
    lists:append(Right, Left).