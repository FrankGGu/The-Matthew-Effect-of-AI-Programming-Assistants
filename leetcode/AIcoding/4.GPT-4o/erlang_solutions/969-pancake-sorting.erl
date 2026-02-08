-module(pancake_sorting).
-export([pancake_sort/1]).

pancake_sort(List) ->
    pancake_sort_helper(List, []).

pancake_sort_helper([], Acc) -> 
    lists:reverse(Acc);
pancake_sort_helper(List, Acc) ->
    Max = lists:max(List),
    {Index, _} = lists:foldl(fun(X, {I, M}) -> 
        if 
            X =:= M -> {I, X};
            true -> {I + 1, M}
        end 
    end, {0, Max}, List),
    Flipped = flip(List, Index),
    pancake_sort_helper(Flipped -- [Max], [Max | Acc]).

flip(List, Index) ->
    {Front, Back} = lists:split(Index + 1, List),
    lists:reverse(Front) ++ Back.