-module(jewelry_supplies).
-export([num_jewels_in_stones/2]).

num_jewels_in_stones(Jewels, Stones) ->
    Sets = sets:from_list(Jewels),
    lists:foldl(fun(Stone, Acc) -> if sets:is_element(Stone, Sets) -> Acc + 1; true -> Acc end end, 0, Stones).