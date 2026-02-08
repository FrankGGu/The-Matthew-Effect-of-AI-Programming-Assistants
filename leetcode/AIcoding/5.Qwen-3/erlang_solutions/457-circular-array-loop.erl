-module(circular_array_loop).
-export([is_circular/1]).

is_circular(Nums) ->
    N = length(Nums),
    Visited = lists:duplicate(N, false),
    is_circular(Nums, Visited, 0).

is_circular(_, _, N) -> true;
is_circular(Nums, Visited, I) ->
    case lists:nth(I + 1, Visited) of
        true -> false;
        _ ->
            lists:put(Visited, I + 1, true),
            Next = (I + lists:nth(I + 1, Nums)) rem N,
            if
                Next == I -> false;
                lists:nth(Next + 1, Nums) * lists:nth(I + 1, Nums) < 0 -> false;
                true ->
                    is_circular(Nums, Visited, Next)
            end
    end.