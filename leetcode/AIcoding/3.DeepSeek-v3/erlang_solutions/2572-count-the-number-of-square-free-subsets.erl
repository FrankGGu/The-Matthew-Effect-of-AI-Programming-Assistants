-module(solution).
-export([square_free_subsets/1]).

square_free_subsets(Nums) ->
    Primes = [2, 3, 5, 7, 11, 13, 17, 19, 23, 29],
    Masks = lists:map(fun num_to_mask/1, Nums),
    ValidMasks = lists:filter(fun(M) -> M =/= -1 end, Masks),
    DP = maps:from_list([{0, 1}]),
    Counts = count_subsets(ValidMasks, DP, Primes),
    (maps:fold(fun(_, V, Acc) -> (Acc + V) rem 1000000007 end, 0, Counts) - 1) rem 1000000007.

num_to_mask(N) ->
    case num_to_mask(N, 0, [2, 3, 5, 7, 11, 13, 17, 19, 23, 29]) of
        {ok, Mask} -> Mask;
        error -> -1
    end.

num_to_mask(1, Mask, _) -> {ok, Mask};
num_to_mask(N, Mask, [P | Primes]) ->
    case N rem P of
        0 ->
            case (N div P) rem P of
                0 -> error;
                _ -> num_to_mask(N div P, Mask bor (1 bsl (P - 2)), Primes)
            end;
        _ -> num_to_mask(N, Mask, Primes)
    end;
num_to_mask(N, _, []) when N > 1 -> error.

count_subsets([], DP, _) -> DP;
count_subsets([Mask | Masks], DP, Primes) ->
    NewDP = maps:fold(fun(CurMask, Count, Acc) ->
        case (CurMask band Mask) of
            0 ->
                NewMask = CurMask bor Mask,
                maps:update_with(NewMask, fun(V) -> (V + Count) rem 1000000007 end, Count, Acc);
            _ -> Acc
        end
    end, DP, DP),
    count_subsets(Masks, NewDP, Primes).