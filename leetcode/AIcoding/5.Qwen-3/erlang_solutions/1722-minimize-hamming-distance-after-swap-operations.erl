-module(solution).
-export([min_hamming_distance/3]).

min_hamming_distance(A, B, Swaps) ->
    N = length(A),
    {_, _, _} = lists:foldl(fun(I, {A1, B1, SwapsLeft}) ->
        if
            SwapsLeft > 0 ->
                case lists:keyfind(A1, 1, B1) of
                    false -> {lists:delete(A1, A1), B1, SwapsLeft};
                    {_, J} ->
                        NewA = lists:delete(A1, A1),
                        NewB = lists:delete({B1, J}, B1),
                        {NewA, NewB, SwapsLeft - 1}
                end;
            true -> {A1, B1, SwapsLeft}
        end
    end, {A, B, Swaps}, lists:seq(0, N-1)),

    lists:sum([1 || I <- lists:seq(0, N-1), lists:nth(I+1, A) /= lists:nth(I+1, B)]).

lists:delete(Elem, List) ->
    lists:reverse(lists:delete(Elem, lists:reverse(List))).