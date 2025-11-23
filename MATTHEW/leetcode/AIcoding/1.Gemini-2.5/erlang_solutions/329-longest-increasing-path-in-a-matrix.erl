-module(solution).
-export([longest_increasing_path/1]).

longest_increasing_path(Matrix) ->
    M = length(Matrix),
    N = length(hd(Matrix)),
    TupleMatrix = list_to_tuple(lists:map(fun list_to_tuple/1, Matrix)),

    InitialMemo = #{},

    {MaxPath, _FinalMemo} = lists:foldl(
        fun(R, {CurrentMax, CurrentMemo}) ->
            lists:foldl(
                fun(C, {InnerMax, InnerMemo}) ->
                    {PathLen, UpdatedMemo} = dfs(TupleMatrix, M, N, R, C, InnerMemo),
                    {max(InnerMax, PathLen), UpdatedMemo}
                end,
                {CurrentMax, CurrentMemo},
                lists:seq(0, N - 1)
            )
        end,
        {0, InitialMemo},
        lists:seq(0, M - 1)
    ),
    MaxPath.

dfs(TupleMatrix, M, N, R, C, Memo) ->
    case maps:find({R, C}, Memo) of
        {ok, PathLen} ->
            {PathLen, Memo};
        error ->
            CurrentVal = element(C + 1, element(R + 1, TupleMatrix)),

            Dirs = [{0, 1}, {0, -1}, {1, 0}, {-1, 0}],

            MaxLen = 1,

            {CalculatedMaxLen, UpdatedMemoAfterNeighbors} = lists:foldl(
                fun({DR, DC}, {AccMaxLen, AccMemo}) ->
                    NR = R + DR,
                    NC = C + DC,

                    if
                        NR >= 0 andalso NR < M andalso NC >= 0 andalso NC < N ->
                            NextVal = element(NC + 1, element(NR + 1, TupleMatrix)),
                            if
                                NextVal > CurrentVal ->
                                    {PathFromNext, NextMemo} = dfs(TupleMatrix, M, N, NR, NC, AccMemo),
                                    {max(AccMaxLen, 1 + PathFromNext), NextMemo};
                                true ->
                                    {AccMaxLen, AccMemo}
                            end;
                        true ->
                            {AccMaxLen, AccMemo}
                    end
                end,
                {MaxLen, Memo},
                Dirs
            ),

            FinalMemo = maps:put({R, C}, CalculatedMaxLen, UpdatedMemoAfterNeighbors),
            {CalculatedMaxLen, FinalMemo}
    end.