-module(gem_supply).
-export([distribute/2]).

distribute(gems, operations) ->
    lists:foldl(fun({X, Y}, Acc) ->
                        Amount = element(X + 1, Acc) div 2,
                        NewAcc = setelement(X + 1, Acc, element(X + 1, Acc) - Amount),
                        setelement(Y + 1, NewAcc, element(Y + 1, NewAcc) + Amount)
                end, gems, operations).