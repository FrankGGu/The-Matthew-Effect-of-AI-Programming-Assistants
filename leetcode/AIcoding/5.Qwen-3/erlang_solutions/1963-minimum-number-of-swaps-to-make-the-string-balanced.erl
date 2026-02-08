-module(min_swaps).
-export([min_swaps/1]).

min_swaps(S) ->
    min_swaps(S, 0, 0).

min_swaps([], _, Swaps) ->
    Swaps;
min_swaps([H | T], Balance, Swaps) ->
    case H of
        $[ ->
            min_swaps(T, Balance + 1, Swaps);
        $] ->
            if
                Balance > 0 ->
                    min_swaps(T, Balance - 1, Swaps);
                true ->
                    min_swaps(T, Balance - 1, Swaps + 1)
            end
    end.