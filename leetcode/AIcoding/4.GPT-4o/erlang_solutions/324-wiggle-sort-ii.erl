%% Definition for the wiggle sort.
%% -record(nums, {val = 0 :: integer()}).

-spec wiggle_sort(Nums :: [integer()]) -> [integer()].
wiggle_sort(Nums) ->
    Sorted = lists:sort(Nums),
    wiggle_sort(Sorted, 0, []).

wiggle_sort([], _, Acc) -> lists:reverse(Acc);
wiggle_sort([H | T], 0, Acc) ->
    wiggle_sort(T, 1, [H | Acc]);
wiggle_sort([H | T], 1, Acc) ->
    wiggle_sort(T, 0, [Acc | [H]]).
