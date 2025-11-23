-module(continuous_subarrays).
-export([number_of_continuous_subarrays/1]).

number_of_continuous_subarrays(Nums) ->
    number_of_continuous_subarrays(Nums, 0, 0, 1).

number_of_continuous_subarrays([], Acc, _, _) ->
    Acc;
number_of_continuous_subarrays([H | T], Acc, L, R) ->
    number_of_continuous_subarrays(T, Acc + count_continuous(H, L, R, T), H, 1).

count_continuous(_, _, _, []) ->
    0;
count_continuous(H, L, R, [H2 | T]) ->
    Diff = abs(H - H2),
    if
        Diff =< 2 ->
            1 + count_continuous(H, H2, 1, T);
        true ->
            0
    end.