-module(solution).
-export([minimum_xor_sum/2]).

minimum_xor_sum(Nums1, Nums2) ->
    N = length(Nums1),
    DP = maps:from_list([{0, 0}]),
    DP1 = solve(Nums1, Nums2, 0, DP, N),
    maps:get((1 bsl N) - 1, DP1).

solve(_, _, Mask, DP, N) when Mask =:= (1 bsl N) - 1 ->
    DP;
solve(Nums1, Nums2, Mask, DP, N) ->
    Count = count_set_bits(Mask),
    lists:foldl(fun(I, AccDP) ->
        case (Mask band (1 bsl I)) =:= 0 of
            true ->
                NewMask = Mask bor (1 bsl I),
                Current = maps:get(Mask, AccDP, infinity),
                Candidate = Current bxor (lists:nth(Count + 1, Nums1) band lists:nth(I + 1, Nums2)),
                case maps:find(NewMask, AccDP) of
                    {ok, Val} when Candidate < Val ->
                        maps:put(NewMask, Candidate, AccDP);
                    error ->
                        maps:put(NewMask, Candidate, AccDP);
                    _ ->
                        AccDP
                end;
            false ->
                AccDP
        end
    end, DP, lists:seq(0, N - 1)).

count_set_bits(Mask) ->
    count_set_bits(Mask, 0).

count_set_bits(0, Count) ->
    Count;
count_set_bits(Mask, Count) ->
    count_set_bits(Mask bsr 1, Count + (Mask band 1)).