-module(solution).
-export([maxMoves/1]).

maxMoves(Grid) ->
    Rows = length(Grid),
    Cols = length(hd(Grid)),

    GridArray = array:from_list(lists:map(fun array:from_list/1, Grid)),

    F_map_memo = fun F_map_memo(R, C, CurrentMemo) ->
        case maps:find({R, C}, CurrentMemo) of
            {ok, Moves} -> {Moves, CurrentMemo};
            _ ->
                Val = array:get(C, array:get(R, GridArray)),
                NextCol = C + 1,

                ChildCoords1 = if R > 0 and NextCol < Cols ->
                                   NextVal = array:get(NextCol, array:get(R - 1, GridArray)),
                                   if NextVal > Val -> [{R - 1, NextCol}]; true -> [] end;
                               true -> []
                               end,

                ChildCoords2 = if NextCol < Cols ->
                                   NextVal = array:get(NextCol, array:get(R, GridArray)),
                                   if NextVal > Val -> [{R, NextCol}]; true -> [] end;
                               true -> []
                               end,

                ChildCoords3 = if R < Rows - 1 and NextCol < Cols ->
                                   NextVal = array:get(NextCol, array:get(R + 1, GridArray)),
                                   if NextVal > Val -> [{R + 1, NextCol}]; true -> [] end;
                               true -> []
                               end,

                AllChildCoords = ChildCoords1 ++ ChildCoords2 ++ ChildCoords3,

                {MaxChildMoves, FinalMemoFromChildren} = lists:foldl(
                    fun({ChildR, ChildC}, {AccMaxMoves, AccMemo}) ->
                        {MovesFromChild, NewAccMemo} = F_map_memo(ChildR, ChildC, AccMemo),
                        {max(AccMaxMoves, 1 + MovesFromChild), NewAccMemo}
                    end,
                    {-1, CurrentMemo},
                    AllChildCoords
                ),

                ResultMoves = if MaxChildMoves == -1 -> 0; true -> MaxChildMoves end,

                NewMemo = maps:put({R, C}, ResultMoves, FinalMemoFromChildren),
                {ResultMoves, NewMemo}
        end
    end,

    InitialMemo = #{},

    {OverallMaxMoves, _FinalMemo} = lists:foldl(
        fun(R, {AccMax, AccMemo}) ->
            {MovesFromR0, NewAccMemo} = F_map_memo(R, 0, AccMemo),
            {max(AccMax, MovesFromR0), NewAccMemo}
        end,
        {0, InitialMemo},
        lists:seq(0, Rows - 1)
    ),

    OverallMaxMoves.