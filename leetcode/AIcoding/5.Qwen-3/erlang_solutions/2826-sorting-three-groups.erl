-module(solving).
-export([sort_groups/1]).

sort_groups(List) ->
    sort_groups(List, 0, 0, 0).

sort_groups([], A, B, C) ->
    min(A, B, C);
sort_groups([H | T], A, B, C) when H == 1 ->
    sort_groups(T, A + 1, B, C);
sort_groups([H | T], A, B, C) when H == 2 ->
    sort_groups(T, A, B + 1, C);
sort_groups([H | T], A, B, C) when H == 3 ->
    sort_groups(T, A, B, C + 1).

min(A, B, C) ->
    lists:min([A, B, C]).