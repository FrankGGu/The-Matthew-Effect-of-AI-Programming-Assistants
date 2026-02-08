-module(solution).
-export([min_time_to_make_sum_at_most_x/2]).

min_time_to_make_sum_at_most_x(Heap, X) ->
    lists:foldl(fun(Elem, Acc) -> 
        case Elem of
            {add, Value} -> [Value | Acc];
            {remove, _} -> lists:tl(Acc)
        end
    end, [], Heap).

heapify([]) -> [];
heapify([H|T]) -> 
    insert(H, heapify(T)).

insert(X, []) -> [X];
insert(X, [H|T]) when X < H -> [X, H | T];
insert(X, [H|T]) -> [H | insert(X, T)].

extract_min([]) -> error;
extract_min([H|T]) -> {H, T}.

min_time_to_make_sum_at_most_x(Heap, X) ->
    List = lists:reverse(Heap),
    Sorted = lists:sort(List),
    min_time(Sorted, 0, 0, X).

min_time([], _, _, _) -> 0;
min_time([H|T], Time, Sum, X) ->
    NewSum = Sum + H,
    if
        NewSum > X -> Time;
        true -> min_time(T, Time + 1, NewSum, X)
    end.