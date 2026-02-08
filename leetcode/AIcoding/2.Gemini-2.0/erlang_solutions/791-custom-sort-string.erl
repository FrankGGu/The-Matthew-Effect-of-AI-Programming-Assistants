-module(custom_sort_string).
-export([custom_sort_string/2]).

custom_sort_string(Order, Str) ->
    OrderList = string:to_list(Order),
    StrList = string:to_list(Str),
    Sorted = lists:sort(fun(A, B) ->
                                 IndexA = lists:index(OrderList, A),
                                 IndexB = lists:index(OrderList, B),
                                 case {IndexA, IndexB} of
                                     {false, false} -> A < B;
                                     {false, _} -> false;
                                     {_, false} -> true;
                                     {IA, IB} -> IA < IB
                                 end
                             end, StrList),
    list_to_binary(Sorted).