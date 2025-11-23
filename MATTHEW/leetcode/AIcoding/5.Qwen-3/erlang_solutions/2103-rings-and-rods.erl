-module(rings_and_rods).
-export([count_points/1]).

count_points(Rings) ->
    Count = lists:foldl(fun(<<C:1/binary, R:1/binary>>, Acc) ->
        Color = binary_to_list(C),
        Rod = binary_to_list(R),
        Key = {Color, Rod},
        maps:update_with(Key, fun(V) -> V + 1 end, 1, Acc)
    end, maps:new(), string:split(Rings, "")),
    maps:fold(fun({_, "R"}, V, Acc) -> Acc + V;
                 ({_, "G"}, V, Acc) -> Acc + V;
                 ({_, "B"}, V, Acc) -> Acc + V;
                 (_, _, Acc) -> Acc
             end, 0, Count).