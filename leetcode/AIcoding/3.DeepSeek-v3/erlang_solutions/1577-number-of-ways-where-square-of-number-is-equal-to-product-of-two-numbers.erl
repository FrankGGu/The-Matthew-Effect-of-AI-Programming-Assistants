-module(solution).
-export([num_triplets/1]).

num_triplets(Nums) ->
    Nums1 = Nums,
    Nums2 = Nums,
    count_triplets(Nums1, Nums2).

count_triplets(Nums1, Nums2) ->
    Map1 = create_map(Nums1),
    Map2 = create_map(Nums2),
    Count1 = count_pairs(Map1, Nums2),
    Count2 = count_pairs(Map2, Nums1),
    Count1 + Count2.

create_map(Nums) ->
    lists:foldl(fun(X, Acc) ->
                    maps:update_with(X, fun(V) -> V + 1 end, 1, Acc)
                end, #{}, Nums).

count_pairs(Map, Nums) ->
    lists:foldl(fun(X, Acc) ->
                    Square = X * X,
                    Acc + count_pairs_for_num(Map, Square, 0, 0, Nums)
                end, 0, Nums).

count_pairs_for_num(Map, Square, Index, Count, Nums) ->
    case Index >= length(Nums) of
        true -> Count;
        false ->
            Y = lists:nth(Index + 1, Nums),
            case Square rem Y of 0 ->
                Z = Square div Y,
                case Y == Z of
                    true ->
                        case maps:get(Y, Map, 0) of
                            C when C >= 2 ->
                                NewCount = Count + (C * (C - 1) div 2,
                                count_pairs_for_num(Map, Square, Index + 1, NewCount, Nums);
                            _ ->
                                count_pairs_for_num(Map, Square, Index + 1, Count, Nums)
                        end;
                    false ->
                        case maps:get(Z, Map, 0) of
                            C when C >= 1 ->
                                NewCount = Count + maps:get(Y, Map, 0) * C,
                                count_pairs_for_num(Map, Square, Index + 1, NewCount, Nums);
                            _ ->
                                count_pairs_for_num(Map, Square, Index + 1, Count, Nums)
                        end
                end;
                _ ->
                    count_pairs_for_num(Map, Square, Index + 1, Count, Nums)
            end
    end.