-module(stock_span).
-export([StockSpanner/0, next/2]).

-record(stock, {price, span}).

StockSpanner() ->
    stock_list = [].

next(Price, StockSpanner) ->
    Span = calculate_span(Price, StockSpanner, 0),
    NewStock = #stock{price=Price, span=Span},
    [NewStock | StockSpanner].

calculate_span(_, [], Span) -> Span;
calculate_span(Price, [H | T], Span) ->
    case H#stock.price of
        P when P <= Price -> calculate_span(Price, T, Span + H#stock.span);
        _ -> Span + 1
    end.