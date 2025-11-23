-spec h_index(Citations :: [integer()]) -> integer().
h_index(Citations) ->
    Sorted = lists:sort(Citations),
    h_index(Sorted, 0, length(Sorted)).

h_index([], MaxH, _) -> MaxH;
h_index([Head | Tail], MaxH, Length) when Head >= Length ->
    h_index(Tail, Length, Length);
h_index([_ | Tail], MaxH, Length) ->
    h_index(Tail, MaxH, Length).
