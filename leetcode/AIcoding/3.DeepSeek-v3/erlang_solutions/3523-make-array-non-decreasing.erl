-spec make_array_non_decreasing(Nums :: [integer()]) -> integer().
make_array_non_decreasing(Nums) ->
    make_array_non_decreasing(Nums, 0).

make_array_non_decreasing([], Steps) -> Steps;
make_array_non_decreasing([_], Steps) -> Steps;
make_array_non_decreasing([X, Y | Rest], Steps) when X > Y ->
    make_array_non_decreasing([Y, Y | Rest], Steps + 1);
make_array_non_decreasing([_ | Tail], Steps) ->
    make_array_non_decreasing(Tail, Steps).