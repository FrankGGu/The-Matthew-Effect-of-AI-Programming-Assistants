-module(solution).
-export([count_black_blocks/3]).

count_black_blocks(N, C, coords) ->
    Count = list_to_tuple([0, 0, 0, 0, 0, 0, 0, 0, 0, 0]),
    lists:foldl(fun({X, Y}, Acc) ->
        idx = (Y rem 3) * 3 + (X rem 3) + 1,
        tuple:setelement(idx, Acc, tuple[element(idx, Acc) + 1])
    end, Count, coords).