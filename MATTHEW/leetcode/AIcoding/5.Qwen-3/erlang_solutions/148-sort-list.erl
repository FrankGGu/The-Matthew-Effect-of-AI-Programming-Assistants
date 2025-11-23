-module(sort_list).
-export([sort_list/1]).

sort_list([]) -> [];
sort_list([H|T]) ->
    {Left, Right} = split(T, [], []),
    [H | sort_list(Left)] ++ sort_list(Right).

split([], Left, Right) -> {Left, Right};
split([H|T], Left, Right) when H < 0 ->
    split(T, [H|Left], Right);
split([H|T], Left, Right) ->
    split(T, Left, [H|Right]).