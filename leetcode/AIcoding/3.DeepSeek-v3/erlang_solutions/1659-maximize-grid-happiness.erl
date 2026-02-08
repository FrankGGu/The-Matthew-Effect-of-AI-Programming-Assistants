-module(solution).
-export([getMaxGridHappiness/4]).

getMaxGridHappiness(M, N, I, E) ->
    Mem = maps:new(),
    {Ans, _} = dp(0, 0, 0, 0, I, E, M, N, Mem),
    Ans.

dp(Pos, PrevRow, Left, Up, I, E, M, N, Mem) ->
    case maps:find({Pos, PrevRow, Left, Up, I, E}, Mem) of
        {ok, Val} -> {Val, Mem};
        error ->
            if
                Pos =:= M * N -> {0, Mem};
                true ->
                    Row = Pos div N,
                    Col = Pos rem N,
                    NewUp = (PrevRow bsr (2 * (N - 1))) band 3,
                    NewLeft = if Col =:= 0 -> 0; true -> Left band 3 end,
                    {Res0, Mem1} = dp(Pos + 1, (PrevRow bsl 2) band ((1 bsl (2 * N)) - 1), NewLeft, 0, I, E, M, N, Mem),
                    Res = Res0,
                    {Res1, Mem2} = if
                        I > 0 ->
                            Add = 120,
                            NewAdd = Add + if NewUp =:= 1 -> -30; NewUp =:= 2 -> 20; true -> 0 end,
                            NewAdd2 = NewAdd + if NewLeft =:= 1 -> -30; NewLeft =:= 2 -> 20; true -> 0 end,
                            {R, M} = dp(Pos + 1, ((PrevRow bsl 2) + 1) band ((1 bsl (2 * N)) - 1), NewLeft, 1, I - 1, E, M, N, Mem1),
                            {R + NewAdd2, M};
                        true -> {Res, Mem1}
                    end,
                    ResI = max(Res, Res1),
                    {Res2, Mem3} = if
                        E > 0 ->
                            Add = 40,
                            NewAdd = Add + if NewUp =:= 1 -> 20; NewUp =:= 2 -> -30; true -> 0 end,
                            NewAdd2 = NewAdd + if NewLeft =:= 1 -> 20; NewLeft =:= 2 -> -30; true -> 0 end,
                            {R, M} = dp(Pos + 1, ((PrevRow bsl 2) + 2) band ((1 bsl (2 * N)) - 1), NewLeft, 2, I, E - 1, M, N, Mem2),
                            {R + NewAdd2, M};
                        true -> {ResI, Mem2}
                    end,
                    ResE = max(ResI, Res2),
                    Mem4 = maps:put({Pos, PrevRow, Left, Up, I, E}, ResE, Mem3),
                    {ResE, Mem4}
            end
    end.