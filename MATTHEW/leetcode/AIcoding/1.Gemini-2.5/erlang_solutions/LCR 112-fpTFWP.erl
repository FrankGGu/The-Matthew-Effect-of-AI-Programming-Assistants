-module(solution).
-export([longest_increasing_path/1]).

get_val(Matrix, R, C) ->
    lists:nth(C + 1, lists:nth(R + 1, Matrix)).

is_valid(R, C, Rows, Cols) ->
    R >= 0 andalso R < Rows andalso C >= 0 andalso C < Cols.

dfs_memo(Matrix, R, C, Rows, Cols, Memo) ->
    case maps:find({R, C}, Memo) of
        {ok, Length} ->
            {Length, Memo};
        error ->
            MaxPath = 1,
            CurrentVal = get_val(Matrix, R, C),
            Directions = [{0, 1}, {0, -1}, {1, 0}, {-1, 0}],
            {FinalMaxPath, FinalMemo} = lists:foldl(
                fun({DR, DC}, {AccMaxPath, AccMemo}) ->
                    NR = R + DR,
                    NC = C + DC,
                    if
                        is_valid(NR, NC, Rows, Cols) andalso get_val(Matrix, NR, NC) > CurrentVal ->
                            {NeighborPathLength, NewMemo} = dfs_memo(Matrix, NR, NC, Rows, Cols, AccMemo),
                            {max(AccMaxPath, 1 + NeighborPathLength), NewMemo};
                        true ->
                            {AccMaxPath, AccMemo}
                    end
                end,
                {MaxPath, Memo},
                Directions
            ),
            UpdatedMemo = maps:put({R, C}, FinalMaxPath, FinalMemo),
            {FinalMaxPath, UpdatedMemo}
    end.

longest_increasing_path(Matrix) ->
    Rows = length(Matrix),
    if Rows == 0 ->
        0;
    true ->
        Cols = length(hd(Matrix)),
        if Cols == 0 ->
            0;
        true ->
            InitialMemo = maps:new(),
            {MaxOverallPath, _FinalMemo} = lists:foldl(
                fun(R, {AccMaxPath, AccMemo}) ->
                    lists:foldl(
                        fun(C, {InnerAccMaxPath, InnerAccMemo}) ->
                            {PathLength, NewMemo} = dfs_memo(Matrix, R, C, Rows, Cols, InnerAccMemo),
                            {max(InnerAccMaxPath, PathLength), NewMemo}
                        end,
                        {AccMaxPath, AccMemo},
                        lists:seq(0, Cols - 1)
                    )
                end,
                {0, InitialMemo},
                lists:seq(0, Rows - 1)
            ),
            MaxOverallPath
        end
    end.