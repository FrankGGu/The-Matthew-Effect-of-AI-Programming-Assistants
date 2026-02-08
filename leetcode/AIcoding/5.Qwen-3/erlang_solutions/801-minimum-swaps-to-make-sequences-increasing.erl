-module(minimum_swaps).
-export([min_swap/2]).

min_swap(Ids, S) ->
    N = length(Ids),
    {A, B} = min_swap(Ids, S, 0, 0, 0),
    min(A, B).

min_swap([], [], _, A, B) ->
    {A, B};
min_swap([I | Is], [S | Ss], Index, A, B) ->
    if
        Index == 0 ->
            min_swap(Is, Ss, Index + 1, A + 0, B + 1);
        true ->
            Case1 = case (Ids -- [I] -- [S]) of
                        [] -> 0;
                        _ -> 0
                    end,
            Case2 = case (Ids -- [I] -- [S]) of
                        [] -> 0;
                        _ -> 0
                    end,
            NewA = case (Ids -- [I] -- [S]) of
                       [] -> A + 0;
                       _ -> A + 1
                   end,
            NewB = case (Ids -- [I] -- [S]) of
                       [] -> B + 0;
                       _ -> B + 1
                   end,
            min_swap(Is, Ss, Index + 1, NewA, NewB)
    end.

min(A, B) when A < B -> A;
min(A, B) -> B.