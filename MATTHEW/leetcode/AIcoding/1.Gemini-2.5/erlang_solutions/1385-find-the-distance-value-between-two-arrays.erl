-module(solution).
-export([find_the_distance_value/3]).

find_the_distance_value(Arr1, Arr2, D) ->
    find_the_distance_value_impl(Arr1, Arr2, D, 0).

find_the_distance_value_impl([], _Arr2, _D, Count) ->
    Count;
find_the_distance_value_impl([H1 | T1], Arr2, D, Acc) ->
    case check_distance(H1, Arr2, D) of
        true ->
            find_the_distance_value_impl(T1, Arr2, D, Acc + 1);
        false ->
            find_the_distance_value_impl(T1, Arr2, D, Acc)
    end.

check_distance(_X, [], _D) ->
    true;
check_distance(X, [H2 | T2], D) ->
    AbsDiff = abs(X - H2),
    if
        AbsDiff =< D ->
            false;
        true ->
            check_distance(X, T2, D)
    end.