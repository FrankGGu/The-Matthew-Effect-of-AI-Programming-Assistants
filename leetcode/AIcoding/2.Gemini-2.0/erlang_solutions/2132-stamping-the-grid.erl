-module(stamping_the_grid).
-export([possible_to_stamp/4]).

possible_to_stamp(Grid, StampHeight, StampWidth, Threshold) ->
    Rows = length(Grid),
    Cols = length(hd(Grid)),
    PrefixSum = prefix_sum(Grid, Rows, Cols),
    Diff = zeros(Rows, Cols),

    stamp_diff(PrefixSum, Diff, StampHeight, StampWidth, Threshold, Rows, Cols),

    PrefixSumDiff = prefix_sum(Diff, Rows, Cols),

    check_valid(Grid, PrefixSumDiff, Rows, Cols).

prefix_sum(Grid, Rows, Cols) ->
    PrefixSum = lists:map(fun(_) -> lists:duplicate(Cols + 1, 0) end, lists:seq(0, Rows)),

    lists:foldl(fun({Row, Col}, Acc) ->
        Acc1 = lists:update(Row + 1, lists:update(Col + 1, element(Col + 1, lists:nth(Row + 1, Acc)) + element(Col + 1, lists:nth(Row, Acc)) + element(Col + 1, lists:nth(Row + 1, Acc)) - element(Col + 1, lists:nth(Row, Acc)), lists:nth(Row + 1, Acc)), Acc),
        lists:update(Row + 1, lists:update(Col + 1, element(Col + 1, lists:nth(Row + 1, Acc1)) + lists:nth(Row, Grid) !! (Col + 1), lists:nth(Row + 1, Acc1)), Acc1)
    end, PrefixSum, [{Row, Col} || Row <- lists:seq(1, Rows), Col <- lists:seq(1, Cols)]).

stamp_diff(PrefixSum, Diff, StampHeight, StampWidth, Threshold, Rows, Cols) ->
    lists:foldl(fun({Row, Col}, Acc) ->
        if Row + StampHeight - 1 =< Rows andalso Col + StampWidth - 1 =< Cols then
            Ones = element(Col + StampWidth, lists:nth(Row + StampHeight, PrefixSum)) - element(Col + StampWidth, lists:nth(Row, PrefixSum)) - element(Col, lists:nth(Row + StampHeight, PrefixSum)) + element(Col, lists:nth(Row, PrefixSum)),
            if StampHeight * StampWidth - Ones =< Threshold then
                Acc1 = lists:update(Row, lists:update(Col, element(Col, lists:nth(Row, Acc)) + 1, lists:nth(Row, Acc)), Acc),
                Acc2 = if Row + StampHeight =< Rows then lists:update(Row + StampHeight, lists:update(Col, element(Col, lists:nth(Row + StampHeight, Acc1)) - 1, lists:nth(Row + StampHeight, Acc1)), Acc1) else Acc1 end,
                Acc3 = if Col + StampWidth =< Cols then lists:update(Row, lists:update(Col + StampWidth, element(Col + StampWidth, lists:nth(Row, Acc2)) - 1, lists:nth(Row, Acc2)), Acc2) else Acc2 end,
                if Row + StampHeight =< Rows andalso Col + StampWidth =< Cols then lists:update(Row + StampHeight, lists:update(Col + StampWidth, element(Col + StampWidth, lists:nth(Row + StampHeight, Acc3)) + 1, lists:nth(Row + StampHeight, Acc3)), Acc3) else Acc3 end
            else
                Acc
            end
        else
            Acc
        end
    end, Diff, [{Row, Col} || Row <- lists:seq(1, Rows), Col <- lists:seq(1, Cols)]).

check_valid(Grid, PrefixSumDiff, Rows, Cols) ->
    lists:all(fun(Row) ->
        lists:all(fun(Col) ->
            if lists:nth(Row, Grid) !! (Col + 1) == 1 then
                true
            else
                element(Col + 1, lists:nth(Row + 1, PrefixSumDiff)) > 0
            end
        end, lists:seq(1, Cols))
    end, lists:seq(1, Rows)).

zeros(Rows, Cols) ->
    lists:map(fun(_) -> lists:duplicate(Cols, 0) end, lists:seq(1, Rows)).