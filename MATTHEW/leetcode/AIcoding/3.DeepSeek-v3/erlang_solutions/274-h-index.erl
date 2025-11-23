-spec h_index(Citations :: [integer()]) -> integer().
h_index(Citations) ->
    Sorted = lists:sort(fun(A, B) -> A >= B end, Citations),
    h_index(Sorted, 1).

h_index([], H) -> H - 1;
h_index([Citation | Rest], H) ->
    if
        Citation >= H -> h_index(Rest, H + 1);
        true -> H - 1
    end.