-module(solution).
-export([countPaths/1]).

-define(MOD, 1000000007).

countPaths(Grid) ->
    M = length(Grid),
    N = length(hd(Grid)),
    {TotalPaths, _FinalMemo} = lists:foldl(
        fun({R, C}, {AccTotal, AccMemo}) ->
            {PathsFromCell, MemoAfterCell} = solve(R, C, Grid, M, N, AccMemo),
            {(AccTotal + PathsFromCell) rem ?MOD, MemoAfterCell}
        end,
        {0, #{}},
        [{R, C} || R <- lists:seq(0, M-1), C <- lists:seq(0, N-1)]
    ),
    TotalPaths.

solve(R, C, Grid, M, N, Memo) ->
    case maps:find({R, C}, Memo) of
        {ok, Val} ->
            {Val, Memo};
        error ->
            CurrentVal = element(C + 1, element(R + 1, Grid)),

            {FinalCount, UpdatedMemo} = lists:foldl(
                fun({DR, DC}, {AccCount, AccMemo}) ->
                    NR = R + DR,
                    NC = C + DC,
                    if
                        NR >= 0 andalso NR < M andalso NC >= 0 andalso NC < N ->
                            NeighborVal = element(NC + 1, element(NR + 1, Grid)),
                            if
                                NeighborVal > CurrentVal ->
                                    {PathCountFromNeighbor, MemoAfterNeighborCall} = solve(NR, NC, Grid, M, N, AccMemo),
                                    {(AccCount + PathCountFromNeighbor) rem ?MOD, MemoAfterNeighborCall};
                                true ->
                                    {AccCount, AccMemo}
                            end;
                        true ->
                            {AccCount, AccMemo}
                    end
                end,
                {1, Memo},
                [{0, 1}, {0, -1}, {1, 0}, {-1, 0}]
            ),
            {FinalCount, maps:put({R, C}, FinalCount, UpdatedMemo)}
    end.