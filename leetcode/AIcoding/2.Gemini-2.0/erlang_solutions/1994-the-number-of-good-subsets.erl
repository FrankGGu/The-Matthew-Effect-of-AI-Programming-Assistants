-module(good_subsets).
-export([number_of_good_subsets/1]).

number_of_good_subsets(Nums) ->
    Primes = [2, 3, 5, 7, 11, 13, 17, 19, 23, 29],
    Masks = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9],
    Factors = [1, 2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 30],
    MaskMap = lists:zip(Factors, [get_mask(F, Primes) || F <- Factors]),
    Counts = lists:foldl(fun(N, Acc) -> maps:update_with(N, fun(V) -> V + 1 end, 1, Acc) end, #{}, Nums),
    DP = maps:from_list([{0, 1}]),
    lists:foldl(fun({Num, Count}, AccDP) ->
        case lists:member(Num, Factors) of
            true ->
                Mask = maps:get(Num, maps:from_list(MaskMap)),
                maps:fold(fun(MaskSoFar, CountSoFar, Acc) ->
                    NewMask = MaskSoFar bor Mask,
                    case (MaskSoFar band Mask) == 0 of
                        true ->
                            maps:update_with(NewMask, fun(V) -> (V + (CountSoFar * Count) rem 1000000007) rem 1000000007 end, (CountSoFar * Count) rem 1000000007, Acc);
                        false ->
                            Acc
                    end
                end, AccDP, AccDP);
            false ->
                AccDP
        end
    end, DP, maps:to_list(Counts)),
    Result = maps:fold(fun(Mask, Count, Acc) ->
        case Mask == 0 of
            true ->
                Acc;
            false ->
                (Acc + Count) rem 1000000007
        end
    end, 0, DP),
    OneCount = maps:get(1, Counts, 0),
    (Result * power(2, OneCount, 1000000007)) rem 1000000007.

get_mask(N, Primes) ->
    get_mask(N, Primes, 0).

get_mask(0, _, Mask) ->
    Mask;
get_mask(N, [P|Rest], Mask) ->
    case N rem P == 0 of
        true ->
            get_mask(N div P, [P|Rest], Mask bor (1 bsl lists:index(Primes, P) - 1));
        false ->
            get_mask(N, Rest, Mask)
    end;
get_mask(N, [], Mask) ->
    Mask.

power(Base, Exp, Mod) ->
    power(Base rem Mod, Exp, Mod, 1).

power(_, 0, _, Acc) ->
    Acc;
power(Base, Exp, Mod, Acc) when Exp rem 2 == 0 ->
    power((Base * Base) rem Mod, Exp div 2, Mod, Acc);
power(Base, Exp, Mod, Acc) ->
    power(Base, Exp - 1, Mod, (Acc * Base) rem Mod).