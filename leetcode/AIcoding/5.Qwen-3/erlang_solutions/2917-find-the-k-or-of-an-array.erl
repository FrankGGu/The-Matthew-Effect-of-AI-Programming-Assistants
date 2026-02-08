-module(k_or).
-export([k_or/2]).

k_or(_, 0) -> 0;
k_or(List, K) ->
    k_or(List, K, 0).

k_or([], _, Acc) -> Acc;
k_or([H|T], K, Acc) ->
    Count = count_bit_positions(H, K),
    k_or(T, K, Acc + Count).

count_bit_positions(Num, K) ->
    count_bit_positions(Num, K, 0, 0).

count_bit_positions(Num, K, Pos, Acc) when Pos < 32 ->
    Bit = (Num bsr Pos) band 1,
    if
        Bit == 1 ->
            case Pos of
                _ when Pos + 1 >= K -> count_bit_positions(Num, K, Pos + 1, Acc + 1);
                _ -> count_bit_positions(Num, K, Pos + 1, Acc)
            end;
        true ->
            count_bit_positions(Num, K, Pos + 1, Acc)
    end;
count_bit_positions(_, _, _, Acc) -> Acc.