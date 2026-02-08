-module(maximum_total_beauty_of_the_gardens).
-export([maximum_total_beauty/2]).

maximum_total_beauty(G, R) ->
    lists:reverse(lists:sort(lists:foldl(fun(Num, Acc) -> [Num | Acc] end, [], G))),
    lists:reverse(lists:sort(lists:foldl(fun(Num, Acc) -> [Num | Acc] end, [], R))),
    {G_sorted, R_sorted} = {lists:reverse(lists:sort(G)), lists:reverse(lists:sort(R))},
    maximum_total_beauty_helper(G_sorted, R_sorted, 0).

maximum_total_beauty_helper([], _, Total) -> Total;
maximum_total_beauty_helper(_, [], Total) -> Total;
maximum_total_beauty_helper([G1 | Gs], [R1 | Rs], Total) ->
    if
        G1 >= R1 -> maximum_total_beauty_helper(Gs, Rs, Total + R1);
        true -> maximum_total_beauty_helper(Gs, Rs, Total + G1)
    end.