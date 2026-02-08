-module(solution).
-export([max_profit/2]).

max_profit(Prices, Fee) ->
    [H | T] = Prices,
    InitialHold = -H,
    InitialFree = 0,
    {_FinalHold, FinalFree} = lists:foldl(
        fun(Price, {Hold, Free}) ->
            NewHold = erlang:max(Hold, Free - Price),
            NewFree = erlang:max(Free, Hold + Price - Fee),
            {NewHold, NewFree}
        end,
        {InitialHold, InitialFree},
        T
    ),
    FinalFree.