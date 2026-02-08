-module(solution).
-export([number_of_good_splits/1]).

number_of_good_splits(Nums) ->
    Counts = count_ones(Nums, #{}),
    case maps:size(Counts) of
        0 -> 0;
        _ ->
            {Left, Right, Res} = split(Nums, #{}, Counts, 0),
            Res
    end.

count_ones([], Acc) -> Acc;
count_ones([1 | T], Acc) ->
    count_ones(T, maps:update_with(1, fun(V) -> V + 1 end, 1, Acc));
count_ones([_ | T], Acc) ->
    count_ones(T, Acc).

split([], _, _, Res) -> {#{}, #{}, Res};
split([H | T], Left, Right, Res) ->
    NewLeft = update_map(H, Left),
    NewRight = case maps:get(H, Right) of
        1 -> maps:remove(H, Right);
        V -> maps:put(H, V - 1, Right)
    end,
    case maps:size(NewLeft) == maps:size(NewRight) of
        true -> split(T, NewLeft, NewRight, Res + 1);
        false -> split(T, NewLeft, NewRight, Res)
    end.

update_map(Key, Map) ->
    maps:update_with(Key, fun(V) -> V + 1 end, 1, Map).