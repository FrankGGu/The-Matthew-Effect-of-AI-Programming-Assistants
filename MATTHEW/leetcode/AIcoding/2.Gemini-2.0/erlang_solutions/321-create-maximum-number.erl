-module(create_maximum_number).
-export([max_number/3]).

max_number(Nums1, Nums2, K) ->
    Len1 = length(Nums1),
    Len2 = length(Nums2),
    Start = max(0, K - Len2),
    End = min(K, Len1),
    lists:foldl(fun(I, Acc) ->
                        Max1 = max_subsequence(Nums1, I),
                        Max2 = max_subsequence(Nums2, K - I),
                        Merged = merge(Max1, Max2),
                        max(Acc, Merged)
                end, [], lists:seq(Start, End)).

max_subsequence(Nums, K) ->
    Stack = lists:foldl(fun(Num, Acc) ->
                                 drop_smaller(Acc, Num, K - length(Acc)),
                                 [Num|Acc]
                         end, [], lists:reverse(Nums)),
    lists:sublist(lists:reverse(Stack), K).

drop_smaller(Acc, Num, Remain) ->
    case {Acc, Remain} of
        {[], _} -> Acc;
        {[_|_], 0} -> Acc;
        {[H|T], _} when Num > H -> drop_smaller(T, Num, Remain - 1);
        _ -> Acc
    end.

merge(Nums1, Nums2) ->
    merge(Nums1, Nums2, []).

merge([], [], Acc) ->
    lists:reverse(Acc);
merge([], Nums2, Acc) ->
    lists:reverse(Acc) ++ Nums2;
merge(Nums1, [], Acc) ->
    lists:reverse(Acc) ++ Nums1;
merge([H1|T1], [H2|T2], Acc) ->
    case compare([H1|T1], [H2|T2]) of
        gt -> merge(T1, [H2|T2], [H1|Acc]);
        _ -> merge([H1|T1], T2, [H2|Acc])
    end.

compare([H1|T1], [H2|T2]) ->
    compare(H1, H2, [H1|T1], [H2|T2]).

compare(H1, H2, [H1|T1], [H2|T2]) when H1 > H2 ->
    gt;
compare(H1, H2, [H1|T1], [H2|T2]) when H1 < H2 ->
    lt;
compare(H1, H2, [H1], [H2]) ->
    eq;
compare(H1, H2, [H1|T1], [H2|T2]) ->
    compare(T1, T2);
compare([], []) ->
    eq;
compare([], _) ->
    lt;
compare(_, []) ->
    gt.

compare([H1|T1], [H2|T2]) ->
    compare(H1, H2, [H1|T1], [H2|T2]).