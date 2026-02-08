-module(minimum_index_of_valid_split).
-export([findValidSplit/1]).

findValidSplit(Nums) ->
    N = length(Nums),
    Left = 0,
    Right = N - 1,
    MaxSoFar = 0,
    findValidSplit(Nums, Left, Right, MaxSoFar).

findValidSplit(_, _, Right, _) when Right < 0 -> -1;
findValidSplit(Nums, Left, Right, MaxSoFar) ->
    case Left of
        Right ->
            if MaxSoFar >= Left -> Left;
               true -> -1
            end;
        _ ->
            MaxSoFar2 = max(MaxSoFar, lists:nth(Left + 1, Nums)),
            if MaxSoFar2 == Left ->
                Left;
               true ->
                    findValidSplit(Nums, Left + 1, Right, MaxSoFar2)
            end
    end.