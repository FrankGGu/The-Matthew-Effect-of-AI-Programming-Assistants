-module(prison_cells_after_n_days).
-export([afterNDays/2]).

afterNDays(Initial, N) ->
    afterNDays(Initial, N, 0, #{}).

afterNDays(Cells, N, Day, Seen) ->
    case maps:is_key(Cells, Seen) of
        true ->
            LoopDay = Day - maps:get(Cells, Seen),
            Remaining = N - Day,
            Offset = Remaining rem LoopDay,
            afterNDays(Cells, Offset, 0, #{});
        false ->
            Next = nextDay(Cells),
            case Day of
                N -> Cells;
                _ -> afterNDays(Next, N, Day + 1, maps:put(Cells, Day, Seen))
            end
    end.

nextDay(Cells) ->
    lists:foldl(fun(I, Acc) ->
                    if
                        I == 0 -> [0 | Acc];
                        I == length(Cells) - 1 -> [0 | Acc];
                        true ->
                            Prev = lists:nth(I, Cells),
                            Next = lists:nth(I + 2, Cells),
                            [case (Prev == Next) of
                                 true -> 0;
                                 false -> 1
                             end | Acc]
                    end
                end, [], lists:seq(0, length(Cells) - 1)).