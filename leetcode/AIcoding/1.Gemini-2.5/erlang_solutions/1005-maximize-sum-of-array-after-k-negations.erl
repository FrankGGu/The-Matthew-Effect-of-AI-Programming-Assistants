-module(solution).
-export([largestSumAfterKNegations/2]).

largestSumAfterKNegations(A, K) ->
    SortedA = lists:sort(A),
    maximize_sum_internal(SortedA, K).

maximize_sum_internal(List, 0) ->
    lists:sum(List);
maximize_sum_internal([], _K) ->
    0;
maximize_sum_internal([H | T] = List, K) ->
    if
        H < 0 ->
            NewH = -H,
            NewList = insert_sorted(NewH, T),
            maximize_sum_internal(NewList, K - 1);
        true ->
            if
                K rem 2 == 0 ->
                    lists:sum(List);
                true ->
                    lists:sum([-H | T])
            end
    end.

insert_sorted(Element, []) ->
    [Element];
insert_sorted(Element, [H | T]) ->
    if
        Element =< H ->
            [Element | [H | T]];
        true ->
            [H | insert_sorted(Element, T)]
    end.