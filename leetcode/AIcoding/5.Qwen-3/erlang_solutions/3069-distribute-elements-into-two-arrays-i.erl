-module(distribute_elements_into_two_arrays_i).
-export([delete_and_increase/2]).

delete_and_increase(Elements, K) ->
    delete_and_increase(Elements, K, [], []).

delete_and_increase([], _, A, B) ->
    lists:sum(A) - lists:sum(B);
delete_and_increase([H | T], K, A, B) ->
    if
        K > 0 ->
            delete_and_increase(T, K - 1, A, [H | B]);
        true ->
            delete_and_increase(T, K, [H | A], B)
    end.