-module(minimum_pair_removal).
-export([min_pair_removal/1]).

min_pair_removal(Nums) ->
    min_pair_removal(Nums, 0).

min_pair_removal([], Acc) ->
    Acc;
min_pair_removal([H|T], Acc) ->
    case find_smaller(H, T) of
        {true, Rest} ->
            min_pair_removal(Rest, Acc + 1);
        false ->
            min_pair_removal(T, Acc)
    end.

find_smaller(_, []) ->
    false;
find_smaller(H, [H2|T]) ->
    if H > H2 ->
        {true, T};
    true ->
        false
    end.