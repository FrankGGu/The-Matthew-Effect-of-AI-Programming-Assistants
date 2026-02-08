-module(solution).
-export([make_array_empty/1]).

make_array_empty(Nums) ->
    make_array_empty(Nums, 1).

make_array_empty([], _) ->
    0;
make_array_empty(Nums, K) ->
    Count = count_occurrences(Nums),
    if
        Count == 0 ->
            0;
        true ->
            Steps = 0,
            NewNums = remove_elements(Nums, K),
            Steps + make_array_empty(NewNums, K + 1)
    end.

count_occurrences(Nums) ->
    lists:foldl(fun(_, Acc) -> Acc + 1 end, 0, Nums).

remove_elements([], _) ->
    [];
remove_elements([H | T], K) ->
    case H rem K of
        0 ->
            remove_elements(T, K);
        _ ->
            [H | remove_elements(T, K)]
    end.