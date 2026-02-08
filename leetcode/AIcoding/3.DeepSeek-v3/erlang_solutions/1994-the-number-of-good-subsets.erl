-module(solution).
-export([number_of_good_subsets/1]).

number_of_good_subsets(Nums) ->
    Primes = [2, 3, 5, 7, 11, 13, 17, 19, 23, 29],
    BadNums = [4, 8, 9, 12, 16, 18, 20, 24, 25, 27, 28],
    PrimeToMask = lists:foldl(fun(Prime, Acc) -> 
                                  maps:put(Prime, 1 bsl (length(Primes) - lists:keyfind(Prime, 1, lists:zip(Primes, lists:seq(1, length(Primes)))))),
                                  Acc) 
                              end, #{}, Primes),
    Freq = lists:foldl(fun(Num, Acc) -> 
                          case lists:member(Num, BadNums) of
                              true -> Acc;
                              false -> maps:update_with(Num, fun(V) -> V + 1 end, 1, Acc)
                          end
                       end, #{}, Nums),
    Ones = maps:get(1, Freq, 0),
    FilteredNums = lists:filter(fun(Num) -> 
                                   not lists:member(Num, BadNums) andalso Num =/= 1 
                                end, Nums),
    DP0 = #{0 => 1},
    DP = lists:foldl(fun(Num, Acc) -> 
                         case maps:get(Num, Freq, 0) of
                             0 -> Acc;
                             Count -> 
                                 Mask = get_mask(Num, PrimeToMask),
                                 maps:fold(fun(ExistingMask, ExistingCount, InnerAcc) -> 
                                               case (ExistingMask band Mask) of
                                                   0 -> 
                                                       NewMask = ExistingMask bor Mask,
                                                       maps:update_with(NewMask, fun(V) -> V + ExistingCount * Count end, ExistingCount * Count, InnerAcc);
                                                   _ -> InnerAcc
                                               end
                                           end, Acc, Acc)
                         end
                      end, DP0, FilteredNums),
    Total = maps:fold(fun(_, V, Sum) -> Sum + V end, 0, DP) - 1,
    case Ones of
        0 -> Total;
        _ -> Total * (1 bsl Ones) rem 1000000007
    end.

get_mask(1, _) -> 0;
get_mask(Num, PrimeToMask) ->
    lists:foldl(fun(Prime, Mask) -> 
                    case Num rem Prime of
                        0 -> Mask bor maps:get(Prime, PrimeToMask);
                        _ -> Mask
                    end
                end, 0, [2, 3, 5, 7, 11, 13, 17, 19, 23, 29]).