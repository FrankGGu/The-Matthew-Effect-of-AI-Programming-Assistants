-module(solution).
-export([rearrange_fruits/1]).

rearrange_fruits(Fruits) ->
    SortedFruits = lists:sort(Fruits),
    rearranged(SortedFruits, []).

rearranged([], Acc) -> lists:reverse(Acc);
rearranged([H | T], Acc) ->
    NewAcc = case Acc of
        [] -> [H];
        [Last | _] when Last =:= H -> Acc ++ [H];
        _ -> Acc ++ [H]
    end,
    rearranged(T, NewAcc).