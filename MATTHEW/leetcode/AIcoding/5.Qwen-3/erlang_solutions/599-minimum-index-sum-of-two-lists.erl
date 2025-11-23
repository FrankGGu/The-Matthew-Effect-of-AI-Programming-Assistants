-module(minimum_index_sum).
-export([findRestaurant/2]).

findRestaurant(List1, List2) ->
    Map = maps:from_list([{Val,Idx} || {Idx, Val} <- lists:enumerate(1, List1)]),
    MinSum = infinity,
    Result = [],
    findRestaurant(List1, List2, Map, MinSum, Result).

findRestaurant([], _, _, _, Acc) ->
    lists:usort(Acc);
findRestaurant([H|T], List2, Map, MinSum, Acc) ->
    case maps:find(H, Map) of
        {ok, Index1} ->
            Index2 = lists:member(H, List2),
            Sum = Index1 + Index2,
            if
                Sum < MinSum ->
                    findRestaurant(T, List2, Map, Sum, [H]);
                Sum == MinSum ->
                    findRestaurant(T, List2, Map, Sum, [H | Acc]);
                true ->
                    findRestaurant(T, List2, Map, MinSum, Acc)
            end;
        error ->
            findRestaurant(T, List2, Map, MinSum, Acc)
    end.

lists:member(Item, List) ->
    lists:member(Item, List).