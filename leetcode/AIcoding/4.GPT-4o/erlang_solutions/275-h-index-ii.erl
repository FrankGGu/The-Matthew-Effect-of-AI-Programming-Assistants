-spec h_index(Citations :: [integer()]) -> integer().
h_index(Citations) ->
    h_index(Citations, 0, length(Citations)).

h_index([], _, _) -> 0;
h_index([H | _], H, _) -> H;
h_index([H | T], Min, Max) when Min < Max ->
    Mid = (Min + Max) div 2,
    case H >= Mid of
        true -> h_index(T, Min, Mid);
        false -> h_index(T, Mid + 1, Max)
    end.
