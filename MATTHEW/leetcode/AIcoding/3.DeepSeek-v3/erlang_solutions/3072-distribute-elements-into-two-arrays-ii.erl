-module(distribute_elements).
-export([distribute_elements/1]).

distribute_elements(Nums) ->
    {Arr1, Arr2} = distribute(Nums, [], [], 0, 0),
    Arr1 ++ Arr2.

distribute([], Arr1, Arr2, _, _) ->
    {lists:reverse(Arr1), lists:reverse(Arr2)};
distribute([H | T], Arr1, Arr2, Cnt1, Cnt2) ->
    case {greater_count(Arr1, H), greater_count(Arr2, H)} of
        {G1, G2} when G1 > G2 ->
            distribute(T, [H | Arr1], Arr2, Cnt1 + 1, Cnt2);
        {G1, G2} when G1 < G2 ->
            distribute(T, Arr1, [H | Arr2], Cnt1, Cnt2 + 1);
        {G1, G2} when G1 == G2 ->
            if
                Cnt1 =< Cnt2 ->
                    distribute(T, [H | Arr1], Arr2, Cnt1 + 1, Cnt2);
                true ->
                    distribute(T, Arr1, [H | Arr2], Cnt1, Cnt2 + 1)
            end
    end.

greater_count(Arr, Val) ->
    length([X || X <- Arr, X > Val]).