-module(wiggle_sort_ii).
-export([wiggle_sort/1]).

wiggle_sort(List) ->
    Sorted = lists:sort(List),
    Len = length(Sorted),
    Mid = (Len + 1) div 2,
    Left = lists:sublist(Sorted, Mid),
    Right = lists:sublist(Sorted, Mid, Len - Mid),
    wiggle_merge(Left, Right, []).

wiggle_merge([], [], Result) ->
    lists:reverse(Result);
wiggle_merge([], Right, Result) ->
    lists:reverse(Result ++ Right);
wiggle_merge(Left, [], Result) ->
    lists:reverse(Result ++ Left);
wiggle_merge([L | Ls], [R | Rs], Result) ->
    wiggle_merge(Ls, Rs, [R, L | Result]).