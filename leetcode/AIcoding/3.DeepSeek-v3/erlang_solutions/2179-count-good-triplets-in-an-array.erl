-module(solution).
-export([good_triplets/2]).

good_triplets(Nums1, Nums2) ->
    Map = maps:from_list([{V, I} || {I, V} <- lists:zip(lists:seq(0, length(Nums1)-1), Nums2)]),
    Pos = [maps:get(V, Map) || V <- Nums1],
    BIT1 = array:new([{size, length(Nums1)+2}, {default, 0}]),
    BIT2 = array:new([{size, length(Nums1)+2}, {default, 0}]),
    {Res, _, _} = lists:foldl(fun(P, {Acc, BIT1Acc, BIT2Acc}) ->
        L = query(P-1, BIT1Acc),
        R = query(length(Nums1), BIT2Acc) - query(P, BIT2Acc),
        NewBIT1 = update(P, 1, BIT1Acc),
        NewBIT2 = update(P, 1, BIT2Acc),
        {Acc + L * R, NewBIT1, NewBIT2}
    end, {0, BIT1, BIT2}, Pos),
    Res.

query(Idx, BIT) ->
    lists:foldl(fun(I, Sum) ->
        case I > 0 of
            true -> Sum + array:get(I, BIT);
            false -> Sum
        end
    end, 0, [Idx band (bnot (Idx - 1)) || _ <- lists:seq(1, 32)]).

update(Idx, Val, BIT) ->
    lists:foldl(fun(I, Acc) ->
        case I < array:size(BIT) of
            true -> array:set(I, array:get(I, Acc) + Val, Acc);
            false -> Acc
        end
    end, BIT, [Idx + (Idx band -Idx) || _ <- lists:seq(1, 32)]).