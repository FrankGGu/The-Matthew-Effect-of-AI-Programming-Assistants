-module(distribute_elements_into_two_arrays_ii).
-export([insertion_sort/1]).

insertion_sort(Elements) ->
    insertion_sort(Elements, []).

insertion_sort([], Result) ->
    lists:reverse(Result);
insertion_sort([H | T], Result) ->
    insertion_sort(T, [H | Result]).

insertion_sort([], _, Result) ->
    lists:reverse(Result);
insertion_sort([H | T], Sorted, Result) ->
    insert(H, Sorted, [], Result).

insert(_Val, [], Left, Result) ->
    lists:append(Left, [Result]);
insert(Val, [H | T], Left, Result) when Val < H ->
    insert(Val, T, [H | Left], Result);
insert(Val, [H | T], Left, Result) ->
    insert(Val, T, [H | Left], Result).