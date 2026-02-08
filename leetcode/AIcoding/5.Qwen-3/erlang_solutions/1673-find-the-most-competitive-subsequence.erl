-module(solution).
-export([most_competitive/2]).

most_competitive(Nums, k) ->
    Len = length(Nums),
    Stack = [],
    do_most_competitive(Nums, 0, Len - 1, k, Stack).

do_most_competitive([], _, _, _, Stack) ->
    Stack;
do_most_competitive([H | T], Index, MaxIndex, K, Stack) ->
    if
        K > 0,
        Stack /= [] ->
            case H < hd(Stack) of
                true ->
                    do_most_competitive(T, Index + 1, MaxIndex, K - 1, [H | tl(Stack)]);
                false ->
                    do_most_competitive(T, Index + 1, MaxIndex, K, [H | Stack])
            end;
        K > 0 ->
            do_most_competitive(T, Index + 1, MaxIndex, K - 1, [H]);
        true ->
            do_most_competitive(T, Index + 1, MaxIndex, K, [H | Stack])
    end.