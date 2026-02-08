-module(increasing_paths).
-export([num_increasing_paths/1]).

num_increasing_paths(Grid) ->
    R = length(Grid),
    C = length(lists:nth(1, Grid)),
    Memo = dict:new(),
    num_increasing_paths_helper(Grid, R, C, Memo).

num_increasing_paths_helper(Grid, R, C, Memo) ->
    Paths = lists:foldl(
        fun(RowIdx, Acc) ->
            lists:foldl(
                fun(ColIdx, Acc2) ->
                    Val = element(ColIdx, lists:nth(RowIdx, Grid)),
                    dict:store({RowIdx, ColIdx}, count_paths(Grid, R, C, RowIdx, ColIdx, Val, Memo), Acc2)
                end,
                Acc,
                lists:seq(1, C)
            )
        end,
        0,
        lists:seq(1, R)
    ),
    lists:foldl(fun({_, V}, Sum) -> (Sum + V) rem 1000000007 end, 0, dict:to_list(Memo)).

count_paths(Grid, R, C, RowIdx, ColIdx, PrevVal, Memo) ->
    case dict:find({RowIdx, ColIdx}, Memo) of
        {ok, Value} ->
            Value;
        error ->
            Paths = count_paths_recursive(Grid, R, C, RowIdx, ColIdx, PrevVal, Memo),
            Paths
    end.

count_paths_recursive(Grid, R, C, RowIdx, ColIdx, PrevVal, Memo) ->
    Val = element(ColIdx, lists:nth(RowIdx, Grid)),
    if Val =< PrevVal then
        1
    else
        Up = case RowIdx > 1 of
            true ->
                UpVal = element(ColIdx, lists:nth(RowIdx - 1, Grid)),
                if UpVal < Val then
                    count_paths(Grid, R, C, RowIdx - 1, ColIdx, Val, Memo)
                else
                    0
                end;
            false ->
                0
        end,
        Down = case RowIdx < R of
            true ->
                DownVal = element(ColIdx, lists:nth(RowIdx + 1, Grid)),
                if DownVal < Val then
                    count_paths(Grid, R, C, RowIdx + 1, ColIdx, Val, Memo)
                else
                    0
                end;
            false ->
                0
        end,
        Left = case ColIdx > 1 of
            true ->
                LeftVal = element(ColIdx - 1, lists:nth(RowIdx, Grid)),
                if LeftVal < Val then
                    count_paths(Grid, R, C, RowIdx, ColIdx - 1, Val, Memo)
                else
                    0
                end;
            false ->
                0
        end,
        Right = case ColIdx < C of
            true ->
                RightVal = element(ColIdx + 1, lists:nth(RowIdx, Grid)),
                if RightVal < Val then
                    count_paths(Grid, R, C, RowIdx, ColIdx + 1, Val, Memo)
                else
                    0
                end;
            false ->
                0
        end,
        (((Up + Down) rem 1000000007 + (Left + Right) rem 1000000007) rem 1000000007 + 1) rem 1000000007
    end.