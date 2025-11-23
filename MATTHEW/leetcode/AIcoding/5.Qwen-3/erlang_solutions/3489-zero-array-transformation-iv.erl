-module(zero_array_transformation_iv).
-export([maxOperations/2]).

maxOperations(Nums, k) ->
    N = length(Nums),
    Sorted = lists:sort(Nums),
    Count = make_ref(),
    do_operations(Sorted, 0, N - 1, Count, 0).

do_operations(_, _, _, _, Acc) when Acc < 0 -> Acc;
do_operations([], _, _, _, Acc) -> Acc;
do_operations([H | T], Left, Right, Count, Acc) ->
    case Right >= Left of
        true ->
            case (H + lists:nth(Right, [H | T])) rem k == 0 of
                true ->
                    NewAcc = Acc + 1,
                    do_operations(T, Left, Right - 1, Count, NewAcc);
                false ->
                    do_operations(T, Left, Right, Count, Acc)
            end;
        false ->
            Acc
    end.