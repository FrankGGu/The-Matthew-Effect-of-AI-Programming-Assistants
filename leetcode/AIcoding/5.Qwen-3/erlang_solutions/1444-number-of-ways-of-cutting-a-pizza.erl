-module(number_of_ways_of_cutting_a_pizza).
-export([ways/1]).

ways(Pizza) ->
    Rows = length(Pizza),
    Cols = length(hd(Pizza)),
    Memo = ets:new(memo, [set, public, named_table]),
    Result = dfs(Pizza, 0, 0, Rows - 1, Cols - 1, 0, Memo),
    ets:delete(Memo),
    Result.

dfs(Pizza, R1, C1, R2, C2, K, Memo) ->
    Key = {R1, C1, R2, C2, K},
    case ets:lookup(Memo, Key) of
        [] ->
            if
                K == 3 -> 1;
                true ->
                    Count = count_apple(Pizza, R1, C1, R2, C2),
                    if
                        Count == 0 -> 0;
                        true ->
                            Total = 0,
                            % Horizontal cuts
                            I = R1 + 1,
                            while I =< R2 do
                                NewK = K + 1,
                                Total = Total + dfs(Pizza, R1, C1, I - 1, C2, NewK, Memo),
                                I = I + 1
                            end,
                            % Vertical cuts
                            J = C1 + 1,
                            while J =< C2 do
                                NewK = K + 1,
                                Total = Total + dfs(Pizza, R1, C1, R2, J - 1, NewK, Memo),
                                J = J + 1
                            end,
                            ets:insert(Memo, {Key, Total}),
                            Total
                    end
            end;
        [{_, Val}] -> Val
    end.

count_apple(Pizza, R1, C1, R2, C2) ->
    Count = 0,
    I = R1,
    while I =< R2 do
        J = C1,
        while J =< C2 do
            if
                lists:nth(I + 1, Pizza) -- [C1] ++ [C2] -- [J] == 1 -> Count = Count + 1;
                true -> ok
            end,
            J = J + 1
        end,
        I = I + 1
    end,
    Count.