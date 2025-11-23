-spec largest_perimeter(Nums :: [integer()]) -> integer().
largest_perimeter(Nums) ->
    Sorted = lists:sort(Nums),
    largest_perimeter(Sorted, 0, -1).

largest_perimeter([], Sum, Max) -> Max;
largest_perimeter([H | T], Sum, Max) ->
    if
        Sum > H -> largest_perimeter(T, Sum + H, Sum + H);
        true -> largest_perimeter(T, Sum + H, Max)
    end.