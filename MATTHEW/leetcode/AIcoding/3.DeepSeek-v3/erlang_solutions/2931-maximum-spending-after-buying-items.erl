-spec max_spending(Items :: [[integer()]]) -> integer().
max_spending(Items) ->
    Sorted = lists:sort(lists:flatten(Items)),
    lists:sum([(I + 1) * V || {I, V} <- lists:zip(lists:seq(0, length(Sorted) - 1), Sorted)]).