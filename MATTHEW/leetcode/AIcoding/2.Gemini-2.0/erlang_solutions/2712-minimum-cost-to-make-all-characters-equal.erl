-module(minimum_cost).
-export([minimum_cost/1]).

minimum_cost(S) ->
    Len = length(S),
    minimum_cost(S, Len, 0, Len-1).

minimum_cost(_S, _Len, L, R) when L >= R ->
    0;
minimum_cost(S, Len, L, R) ->
    LeftCost =
        case lists:nth(L+1, S) of
            $0 -> L+1;
            $1 -> L+1
        end,
    RightCost = Len - R,
    min(LeftCost, RightCost).