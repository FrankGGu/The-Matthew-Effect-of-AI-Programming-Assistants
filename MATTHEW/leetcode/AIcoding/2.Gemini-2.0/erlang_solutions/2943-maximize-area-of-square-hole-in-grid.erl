-module(maximize_area_of_square_hole).
-export([max_area_square_hole/2]).

max_area_square_hole(N, HBars, VBars) ->
    H = sort(HBars),
    V = sort(VBars),
    H_Len = longest_consecutive(H),
    V_Len = longest_consecutive(V),
    Side = min(H_Len + 1, V_Len + 1),
    Side * Side.

longest_consecutive(Bars) ->
    longest_consecutive(Bars, 0, 1).

longest_consecutive([], Max, Current) ->
    max(Max, Current -1);
longest_consecutive([_], Max, Current) ->
    max(Max, Current - 1);
longest_consecutive([H1, H2 | Rest], Max, Current) ->
    if
        H2 == H1 + 1 ->
            longest_consecutive([H2 | Rest], Max, Current + 1);
        true ->
            longest_consecutive([H2 | Rest], max(Max, Current - 1), 1)
    end.

sort(List) ->
    lists:sort(List).