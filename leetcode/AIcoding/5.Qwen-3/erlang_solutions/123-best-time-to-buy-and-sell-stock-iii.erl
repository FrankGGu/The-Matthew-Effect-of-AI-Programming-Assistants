-module(solution).
-export([max_profit/1]).

max_profit(Prices) ->
    N = length(Prices),
    if
        N < 2 -> 0;
        true ->
            FirstBuy = lists:seq(0, N-1),
            FirstSell = lists:seq(0, N-1),
            SecondBuy = lists:seq(0, N-1),
            SecondSell = lists:seq(0, N-1),
            FirstBuy1 = lists:foldl(fun(I, Acc) ->
                case I of
                    0 -> [ -hd(Prices) | Acc ];
                    _ -> [ max( hd(lists:sublist(Prices, I)) - hd(lists:sublist(Prices, I-1)), hd(Acc) ) | Acc ]
                end
            end, [], lists:seq(1, N)),
            FirstSell1 = lists:foldl(fun(I, Acc) ->
                case I of
                    0 -> [ 0 | Acc ];
                    _ -> [ max( hd(lists:sublist(Prices, I)) + hd(lists:sublist(FirstBuy1, I)), hd(Acc) ) | Acc ]
                end
            end, [], lists:seq(1, N)),
            SecondBuy1 = lists:foldl(fun(I, Acc) ->
                case I of
                    0 -> [ -hd(Prices) | Acc ];
                    _ -> [ max( hd(lists:sublist(Prices, I)) - hd(lists:sublist(Prices, I-1)) + hd(lists:sublist(FirstSell1, I-1)), hd(Acc) ) | Acc ]
                end
            end, [], lists:seq(1, N)),
            SecondSell1 = lists:foldl(fun(I, Acc) ->
                case I of
                    0 -> [ 0 | Acc ];
                    _ -> [ max( hd(lists:sublist(Prices, I)) + hd(lists:sublist(SecondBuy1, I)), hd(Acc) ) | Acc ]
                end
            end, [], lists:seq(1, N)),
            hd(lists:reverse(SecondSell1))
    end.