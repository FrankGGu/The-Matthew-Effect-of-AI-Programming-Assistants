-module(zigzag).
-export([movesToMakeZigzag/1]).

movesToMakeZigzag(Nums) ->
    N = length(Nums),
    Moves1 = calculateMoves(Nums, N, 0),
    Moves2 = calculateMoves(Nums, N, 1),
    min(Moves1, Moves2).

calculateMoves(Nums, N, Start) ->
    calculateMovesHelper(Nums, N, Start, 0).

calculateMovesHelper(_Nums, _N, _I, Moves) when _I >= _N ->
    Moves;
calculateMovesHelper(Nums, N, I, Moves) ->
    Val = lists:nth(I + 1, Nums),
    {Left, Right} = getNeighbors(Nums, N, I),
    Target = case {Left, Right} of
                 {none, none} ->
                     Val;
                 {none, R} ->
                     min(Val, R - 1);
                 {L, none} ->
                     min(Val, L - 1);
                 {L, R} ->
                     min(Val, min(L, R) - 1)
             end,
    NewMoves = Moves + max(0, Val - Target),
    calculateMovesHelper(Nums, N, I + 2, NewMoves).

getNeighbors(_Nums, N, I) when I < 0 or I >= N ->
    {none, none};
getNeighbors(Nums, N, I) ->
    Left = case I - 1 >= 0 of
               true -> lists:nth(I, Nums);
               false -> none
           end,
    Right = case I + 1 < N of
                true -> lists:nth(I + 2, Nums);
                false -> none
            end,
    {Left, Right}.