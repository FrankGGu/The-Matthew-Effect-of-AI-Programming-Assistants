-module(cherry_pickup_ii).
-export([cherry_pickup/1]).

cherry_pickup(Grid) ->
    Rows = length(Grid),
    Cols = length(hd(Grid)),
    memo(Grid, Rows, Cols).

memo(Grid, Rows, Cols) ->
    Memo = array:new([Rows, Cols, Cols], {undefined}),

    F = fun(R, C1, C2, F2) ->
        case array:get({R, C1, C2}, Memo) of
            undefined ->
                case R == Rows ->
                    array:set({R, C1, C2}, 0, Memo),
                    0;
                true ->
                    MaxCherry = -1,
                    for(DC1 <- -1 to 1,
                        DC2 <- -1 to 1,
                        C1Next = C1 + DC1,
                        C2Next = C2 + DC2,
                        C1Next >= 1,
                        C1Next =< Cols,
                        C2Next >= 1,
                        C2Next =< Cols,
                    begin
                        Cherry = F2(R + 1, C1Next, C2Next, F2),
                        MaxCherry = max(MaxCherry, Cherry)
                    end),

                    Cherries = case C1 == C2 of
                                    true -> lists:nth(C1, lists:nth(R, Grid));
                                    false -> lists:nth(C1, lists:nth(R, Grid)) + lists:nth(C2, lists:nth(R, Grid))
                                end,

                    Result = Cherries + MaxCherry,
                    array:set({R, C1, C2}, Result, Memo),
                    Result
            end;
        _ ->
            array:get({R, C1, C2}, Memo)
    end,

    F(1, 1, Cols, F).