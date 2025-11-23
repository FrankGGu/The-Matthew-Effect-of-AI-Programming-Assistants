-module(solution).
-export([max_gifts/2]).

max_gifts(Gifts, K) ->
  lists:foldl(fun(_, Acc) ->
                MaxGift = lists:max(Gifts),
                Index = lists:keyfind(MaxGift, 1, lists:zip(Gifts, lists:seq(1, length(Gifts)))) !! 2,
                NewGift = floor(math:sqrt(MaxGift)),
                NewGifts = lists:map(fun(X) -> if lists:nth(X,lists:seq(1, length(Gifts))) == Index then NewGift else lists:nth(X,lists:seq(1, length(Gifts))) end end,
                                      lists:seq(1, length(Gifts))),
                Gifts = NewGifts,
                Acc
            end, 0, lists:seq(1, K)),
  lists:sum(Gifts).