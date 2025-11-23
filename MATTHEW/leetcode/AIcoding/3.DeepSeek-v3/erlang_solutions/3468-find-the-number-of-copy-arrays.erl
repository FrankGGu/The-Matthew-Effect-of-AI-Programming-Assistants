-module(solution).
-export([numberOfGoodSubsets/1]).

numberOfGoodSubsets(Nums) ->
    Primes = [2, 3, 5, 7, 11, 13, 17, 19, 23, 29],
    BadNums = [4, 8, 9, 12, 16, 18, 20, 24, 25, 27, 28],
    Count1 = lists:foldl(fun(X, Acc) -> 
                            case X of
                                1 -> Acc + 1;
                                _ -> Acc
                            end
                         end, 0, Nums),
    Filtered = lists:filter(fun(X) -> 
                               not lists:member(X, BadNums) andalso X =/= 1 
                            end, Nums),
    PrimeMasks = lists:map(fun(X) -> 
                              lists:foldl(fun(P, Mask) -> 
                                            case X rem P of
                                                0 -> Mask bor (1 bsl (length(Primes) - lists:member(P, Primes)));
                                                _ -> Mask
                                            end
                                         end, 0, Primes)
                           end, Filtered),
    DP = maps:new(),
    DP1 = maps:put(0, 1, DP),
    lists:foldl(fun(Mask, Acc) -> 
                   maps:fold(fun(ExistingMask, Count, InnerAcc) -> 
                                 case (ExistingMask band Mask) of
                                     0 -> 
                                         NewMask = ExistingMask bor Mask,
                                         case maps:get(NewMask, InnerAcc, 0) of
                                             Val -> maps:put(NewMask, (Val + Count) rem 1000000007, InnerAcc)
                                         end;
                                     _ -> InnerAcc
                                 end
                              end, Acc, Acc)
                end, DP1, PrimeMasks),
    Total = lists:foldl(fun({_, V}, Sum) -> (Sum + V) rem 1000000007 end, 0, maps:to_list(DP1)) - 1,
    case Count1 of
        0 -> Total;
        _ -> (Total * (1 bsl Count1)) rem 1000000007
    end.