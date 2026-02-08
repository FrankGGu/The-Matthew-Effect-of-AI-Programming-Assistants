-module(minimum_replacements).
-export([minimum_replacements/1]).

minimum_replacements(Nums) ->
    minimum_replacements(Nums, length(Nums) - 1, 0, infinity).

minimum_replacements([], _, Acc, _) ->
    Acc;
minimum_replacements([_], _, Acc, _) ->
    Acc;
minimum_replacements(Nums, Index, Acc, Prev) ->
    if Index < 0 ->
        Acc
    else
        N = lists:nth(Index + 1, Nums),
        if N > Prev ->
            minimum_replacements(Nums, Index - 1, Acc + (0), Prev)
        else
            Parts = (Prev + N - 1) div N,
            NewAcc = Acc + (Parts - 1),
            NewPrev = Prev div Parts,
            minimum_replacements(Nums, Index - 1, NewAcc, NewPrev)
        end
    end.