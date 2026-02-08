-module(largest_number_at_least_twice_of_others).
-export([dominantIndex/1]).

dominantIndex(Nums) ->
    dominantIndex(Nums, 0, -1, -1).

dominantIndex([], _Index, -1, _Max) ->
    0;
dominantIndex([], _Index, MaxIndex, _Max) ->
    MaxIndex;
dominantIndex([H | T], Index, -1, _Max) ->
    dominantIndex(T, Index + 1, Index, H);
dominantIndex([H | T], Index, MaxIndex, Max) ->
    if
        H >= 2 * Max ->
            dominantIndex(T, Index + 1, Index, H);
        true ->
            dominantIndex(T, Index + 1, MaxIndex, Max)
    end.