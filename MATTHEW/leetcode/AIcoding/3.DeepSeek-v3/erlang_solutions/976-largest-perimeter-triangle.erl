-spec largest_perimeter(Nums :: [integer()]) -> integer().
largest_perimeter(Nums) ->
    Sorted = lists:sort(fun(A, B) -> A >= B end, Nums),
    check_triangles(Sorted).

check_triangles([A, B, C | Rest]) ->
    case A < B + C of
        true -> A + B + C;
        false -> check_triangles([B, C | Rest])
    end;
check_triangles(_) -> 0.