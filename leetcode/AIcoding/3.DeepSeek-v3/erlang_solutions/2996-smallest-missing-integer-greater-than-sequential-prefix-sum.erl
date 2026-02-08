-spec smallest_missing_integer(Nums :: [integer()]) -> integer().
smallest_missing_integer(Nums) ->
    {Prefix, _} = lists:splitwith(fun(X) -> X >= 1 end, Nums),
    case Prefix of
        [] -> 1;
        _ ->
            Sorted = lists:sort(Prefix),
            find_missing(Sorted, 1)
    end.

find_missing([], Expected) -> Expected;
find_missing([H | T], Expected) when H =:= Expected -> find_missing(T, Expected + 1);
find_missing([H | _], Expected) when H > Expected -> Expected;
find_missing([_ | T], Expected) -> find_missing(T, Expected).