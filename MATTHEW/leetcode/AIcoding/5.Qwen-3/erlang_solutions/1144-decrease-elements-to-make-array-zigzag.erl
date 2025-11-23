-module(zigzag).
-export([min_flips/1]).

min_flips(Nums) ->
    min_flips(Nums, 0, 0).

min_flips([], _, Count) ->
    Count;
min_flips([H | T], Index, Count) ->
    case Index rem 2 of
        0 ->
            if
                H >= lists:nth(Index + 1, T) ->
                    min_flips(T, Index + 1, Count + 1);
                true ->
                    min_flips(T, Index + 1, Count)
            end;
        1 ->
            if
                H >= lists:nth(Index + 1, T) ->
                    min_flips(T, Index + 1, Count + 1);
                true ->
                    min_flips(T, Index + 1, Count)
            end
    end.