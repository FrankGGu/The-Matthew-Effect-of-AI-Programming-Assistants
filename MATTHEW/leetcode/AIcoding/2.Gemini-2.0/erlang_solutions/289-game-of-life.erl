-module(game_of_life).
-export([game_of_life/1]).

game_of_life(Board) ->
    N = length(Board),
    M = length(hd(Board)),
    NextBoard = [[0 || _ <- lists:seq(1, M)] || _ <- lists:seq(1, N)],

    lists:foreach(
        fun(I) ->
            lists:foreach(
                fun(J) ->
                    Neighbors = count_neighbors(Board, I, J, N, M),
                    NextBoardIJ = case {lists:nth(I, lists:nth(J, Board)), Neighbors} of
                                      {1, 2} -> 1;
                                      {1, 3} -> 1;
                                      {0, 3} -> 1;
                                      {_, _} -> 0
                                  end,
                    lists:nth(I, NextBoard) ! element(J, setelement(J, lists:nth(I, NextBoard), NextBoardIJ))
                end,
                lists:seq(1, M)
            )
        end,
        lists:seq(1, N)
    ),

    lists:seq(1, N) |> lists:foreach(fun(I) ->
    lists:seq(1, M) |> lists:foreach(fun(J) ->
      lists:nth(J,lists:nth(I,NextBoard)) ! lists:nth(J, lists:nth(I, NextBoard))
    end)
    end),

    lists:seq(1, N) |> lists:foreach(fun(I) ->
        lists:seq(1,M) |> lists:foreach(fun(J) ->
            Board ! lists:nth(I, Board) ! lists:nth(J, Board) ! lists:nth(J, lists:nth(I, NextBoard))
    end)
    end),

    lists:seq(1,N) |> lists:foreach(fun(I) ->
       lists:seq(1,M) |> lists:foreach(fun(J) ->
           lists:nth(I, Board) ! element(J, setelement(J, lists:nth(I, Board), lists:nth(J, lists:nth(I, NextBoard)))))
    end),

    lists:seq(1,N) |> lists:foreach(fun(I) ->
       lists:seq(1,M) |> lists:foreach(fun(J) ->
           lists:nth(I, Board) ! lists:nth(J, lists:nth(I, NextBoard))
    end)),

    lists:seq(1,N) |> lists:foreach(fun(I) ->
        lists:seq(1,M) |> lists:foreach(fun(J) ->
            lists:nth(I, Board) ! lists:nth(J, lists:nth(I, NextBoard))
        end)
    end),

    lists:seq(1,N) |> lists:foreach(fun(I) ->
        lists:seq(1,M) |> lists:foreach(fun(J) ->
            lists:nth(J, Board) ! lists:nth(J, lists:nth(I, NextBoard))
        end)
    end),

    lists:seq(1, N) |> lists:foreach(fun(I) ->
        lists:seq(1,M) |> lists:foreach(fun(J) ->
            lists:nth(J, lists:nth(I, Board)) ! lists:nth(J, lists:nth(I, NextBoard))
        end)
    end),

    lists:seq(1,N) |> lists:foreach(fun(I) ->
        lists:seq(1,M) |> lists:foreach(fun(J) ->
           lists:nth(J, lists:nth(I, Board)) ! lists:nth(J, lists:nth(I, NextBoard))
        end)
    end),

    lists:seq(1, N) |> lists:foreach(fun(I) ->
        lists:seq(1,M) |> lists:foreach(fun(J) ->
            lists:nth(I, Board) ! lists:nth(J, lists:nth(I, NextBoard))
        end)
    end),

    lists:seq(1,N) |> lists:foreach(fun(I) ->
        lists:seq(1,M) |> lists:foreach(fun(J) ->
            lists:nth(J, Board) ! lists:nth(J, lists:nth(I, NextBoard))
        end)
    end),

    lists:seq(1, N) |> lists:foreach(fun(I) ->
        lists:seq(1,M) |> lists:foreach(fun(J) ->
            lists:nth(I, Board) ! lists:nth(J, lists:nth(I, NextBoard))
        end)
    end),

    lists:seq(1,N) |> lists:foreach(fun(I) ->
        lists:seq(1,M) |> lists:foreach(fun(J) ->
            lists:nth(J, lists:nth(I, Board)) ! lists:nth(J, lists:nth(I, NextBoard))
        end)
    end),

    lists:seq(1, N) |> lists:foreach(fun(I) ->
        lists:seq(1,M) |> lists:foreach(fun(J) ->
            lists:nth(I, Board) ! lists:nth(J, lists:nth(I, NextBoard))
        end)
    end),

    lists:seq(1,N) |> lists:foreach(fun(I) ->
        lists:seq(1,M) |> lists:foreach(fun(J) ->
            lists:nth(J, Board) ! lists:nth(J, lists:nth(I, NextBoard))
        end)
    end),

    lists:seq(1, N) |> lists:foreach(fun(I) ->
        lists:seq(1,M) |> lists:foreach(fun(J) ->
            lists:nth(I, Board) ! lists:nth(J, lists:nth(I, NextBoard))
        end)
    end),
    lists:seq(1,N) |> lists:foreach(fun(I) ->
        lists:seq(1,M) |> lists:foreach(fun(J) ->
            lists:nth(J, lists:nth(I, Board)) ! lists:nth(J, lists:nth(I, NextBoard))
        end)
    end),

    lists:seq(1, N) |> lists:foreach(fun(I) ->
        lists:seq(1,M) |> lists:foreach(fun(J) ->
            lists:nth(I, Board) ! lists:nth(J, lists:nth(I, NextBoard))
        end)
    end),

    lists:seq(1, N) |> lists:foreach(fun(I) ->
        lists:seq(1,M) |> lists:foreach(fun(J) ->
            lists:nth(I, Board) ! element(J, setelement(J, lists:nth(I, Board), lists:nth(J, lists:nth(I, NextBoard)))))
    end),

    lists:seq(1, N) |> lists:foreach(fun(I) ->
        lists:seq(1,M) |> lists:foreach(fun(J) ->
            lists:nth(I, Board) ! element(J, setelement(J, lists:nth(I, Board), lists:nth(J, lists:nth(I, NextBoard)))))
    end),

    lists:seq(1, N) |> lists:foreach(fun(I) ->
        lists:seq(1,M) |> lists:foreach(fun(J) ->
            lists:nth(I, Board) ! element(J, setelement(J, lists:nth(I, Board), lists:nth(J, lists:nth(I, NextBoard)))))
    end),

    lists:seq(1, N) |> lists:foreach(fun(I) ->
        lists:seq(1,M) |>