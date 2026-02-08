-module(stock_spanner).
-export([new/0, next/2]).

new() ->
    [].

next(Stack, Price) ->
    calculate_span(Stack, Price, 1).

calculate_span([{PrevPrice, PrevSpan} | RestStack], CurrentPrice, AccSpan) when PrevPrice =< CurrentPrice ->
    calculate_span(RestStack, CurrentPrice, AccSpan + PrevSpan);
calculate_span(Stack, CurrentPrice, AccSpan) ->
    {[{CurrentPrice, AccSpan} | Stack], AccSpan}.