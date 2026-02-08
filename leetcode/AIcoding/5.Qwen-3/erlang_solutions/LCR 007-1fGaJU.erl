-module(three_sum).
-export([three_sum/1]).

three_sum(Nums) ->
    Sorted = lists:sort(Nums),
    do_three_sum(Sorted, []).

do_three_sum([], _) ->
    [];
do_three_sum([A | Rest], Acc) ->
    case Rest of
        [] ->
            Acc;
        _ ->
            do_two_sum(A, Rest, Acc)
    end.

do_two_sum(_, [], Acc) ->
    Acc;
do_two_sum(A, [B | Rest], Acc) ->
    C = -A - B,
    case lists:member(C, Rest) of
        true ->
            case lists:member([A, B, C], Acc) of
                false ->
                    do_two_sum(A, Rest, [[A, B, C] | Acc]);
                true ->
                    do_two_sum(A, Rest, Acc)
            end;
        false ->
            do_two_sum(A, Rest, Acc)
    end.