-module(largest_plus_sign).
-export([maximum_plus_sign/1]).

maximum_plus_sign(Grid) ->
    N = length(Grid),
    Max = 0,
    {Left, Right, Up, Down} = init_directions(Grid),
    lists:foldl(fun(I, Acc) ->
        lists:foldl(fun(J, Acc2) ->
            Min = min(min(Left[I][J], Right[I][J]), min(Up[I][J], Down[I][J])),
            max(Acc2, Min)
        end, Acc, lists:seq(0, N-1))
    end, 0, lists:seq(0, N-1)).

init_directions(Grid) ->
    N = length(Grid),
    Left = array_init(N, N),
    Right = array_init(N, N),
    Up = array_init(N, N),
    Down = array_init(N, N),
    lists:foreach(fun(I) ->
        lists:foreach(fun(J) ->
            if
                Grid!!I!!J == 1 ->
                    Left[I][J] = case J of 0 -> 0; _ -> Left[I][J-1] + 1 end,
                    Up[I][J] = case I of 0 -> 0; _ -> Up[I-1][J] + 1 end;
                true ->
                    Left[I][J] = 0,
                    Up[I][J] = 0
            end
        end, lists:seq(0, N-1))
    end, lists:seq(0, N-1)),
    lists:foreach(fun(I) ->
        lists:foreach(fun(J) ->
            if
                Grid!!I!!J == 1 ->
                    Right[I][J] = case J of N-1 -> 0; _ -> Right[I][J+1] + 1 end,
                    Down[I][J] = case I of N-1 -> 0; _ -> Down[I+1][J] + 1 end;
                true ->
                    Right[I][J] = 0,
                    Down[I][J] = 0
            end
        end, lists:seq(0, N-1))
    end, lists:reverse(lists:seq(0, N-1))),
    {Left, Right, Up, Down}.

array_init(N, M) ->
    lists:map(fun(_) -> array:new(M, {default, 0}) end, lists:seq(0, N-1)).