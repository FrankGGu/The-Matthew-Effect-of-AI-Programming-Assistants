-spec max_coins(Bags :: [integer()], K :: integer()) -> integer().
max_coins(Bags, K) ->
    Sorted = lists:sort(fun(A, B) -> A >= B end, Bags),
    sum(lists:sublist(Sorted, K)).

sum(List) ->
    sum(List, 0).

sum([], Acc) ->
    Acc;
sum([H|T], Acc) ->
    sum(T, Acc + H).