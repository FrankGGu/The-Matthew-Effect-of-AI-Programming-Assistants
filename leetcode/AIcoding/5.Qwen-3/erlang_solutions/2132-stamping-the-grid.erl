-module(stamping_the_grid).
-export([possible_to_stamp/2]).

possible_to_stamp(Grid, K) ->
    Rows = length(Grid),
    Cols = length(hd(Grid)),
    if
        K > Rows orelse K > Cols -> false;
        true ->
            Stamped = array:new({size, Rows}, {default, 0}),
            Marked = array:new({size, Rows}, {default, 0}),
            Marked1 = mark(Grid, Stamped, Marked, K, 0, 0),
            check(Marked1, Grid, K)
    end.

mark([], _, Marked, _, _, _) -> Marked;
mark([Row | Rest], Stamped, Marked, K, R, C) ->
    if
        C == length(Row) ->
            mark(Rest, Stamped, Marked, K, R + 1, 0);
        true ->
            case lists:nth(C + 1, Row) of
                1 ->
                    if
                        R + K <= length(Grid) andalso C + K <= length(Row) ->
                            Stamped1 = stamp(Stamped, R, C, K),
                            Marked1 = mark_area(Marked, R, C, K),
                            mark([Row | Rest], Stamped1, Marked1, K, R, C + 1);
                        true ->
                            mark([Row | Rest], Stamped, Marked, K, R, C + 1)
                    end;
                _ ->
                    mark([Row | Rest], Stamped, Marked, K, R, C + 1)
            end
    end.

stamp(Stamped, R, C, K) ->
    F = fun(I, J, Acc) ->
            if
                I >= R andalso I < R + K andalso J >= C andalso J < C + K ->
                    array:set({I, J}, 1, Acc);
                true ->
                    Acc
            end
        end,
    array:foldl(F, Stamped, array:size(Stamped)).

mark_area(Marked, R, C, K) ->
    F = fun(I, J, Acc) ->
            if
                I >= R andalso I < R + K andalso J >= C andalso J < C + K ->
                    array:set({I, J}, 1, Acc);
                true ->
                    Acc
            end
        end,
    array:foldl(F, Marked, array:size(Marked)).

check(Marked, Grid, K) ->
    F = fun(R, Row) ->
            F1 = fun(C, Cell) ->
                    if
                        Cell == 1 ->
                            true;
                        true ->
                            case array:get({R, C}, Marked) of
                                1 -> true;
                                _ -> false
                            end
                    end,
            lists:all(F1, Row)
        end,
    lists:all(F, Grid).

array:new({size, Size}, {default, Default}) ->
    array:new(Size, {default, Default}).

array:set({I, J}, Value, Array) ->
    array:set(I * array:size(Array) + J, Value, Array).

array:get({I, J}, Array) ->
    array:get(I * array:size(Array) + J, Array).

array:foldl(F, Acc, Size) ->
    array:foldl(F, Acc, array:new(Size, {default, 0})).