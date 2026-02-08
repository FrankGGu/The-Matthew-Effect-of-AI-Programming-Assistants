-module(k_smallest_pairs).
-export([k_smallest_pairs/2]).

k_smallest_pairs(Nums1, Nums2) ->
    k_smallest_pairs(Nums1, Nums2, 1, []).

k_smallest_pairs(_, _, K, Result) when K == 0 ->
    lists:reverse(Result);
k_smallest_pairs([], _, _, Result) ->
    lists:reverse(Result);
k_smallest_pairs(_, [], _, Result) ->
    lists:reverse(Result);
k_smallest_pairs(Nums1, Nums2, K, Result) ->
    Min = find_min(Nums1, Nums2),
    NewResult = [Min | Result],
    {A, B} = Min,
    IndexA = lists:member(A, Nums1),
    IndexB = lists:member(B, Nums2),
    case IndexA of
        false -> k_smallest_pairs(Nums1, Nums2, K-1, NewResult);
        _ ->
            case IndexB of
                false -> k_smallest_pairs(Nums1, Nums2, K-1, NewResult);
                _ ->
                    UpdatedNums1 = lists:delete(A, Nums1),
                    UpdatedNums2 = lists:delete(B, Nums2),
                    k_smallest_pairs(UpdatedNums1, UpdatedNums2, K-1, NewResult)
            end
    end.

find_min([], _) ->
    [];
find_min(_, []) ->
    [];
find_min([H1 | T1], [H2 | T2]) ->
    [H1, H2].

generate_pairs([], _) ->
    [];
generate_pairs([H | T], L) ->
    [[H, X] || X <- L] ++ generate_pairs(T, L).

sort_pairs(Pairs) ->
    lists:sort(fun([A, B], [C, D]) -> (A + B) =< (C + D) end, Pairs).

k_smallest_pairs(Nums1, Nums2, K) ->
    Pairs = generate_pairs(Nums1, Nums2),
    SortedPairs = sort_pairs(Pairs),
    lists:sublist(SortedPairs, K).