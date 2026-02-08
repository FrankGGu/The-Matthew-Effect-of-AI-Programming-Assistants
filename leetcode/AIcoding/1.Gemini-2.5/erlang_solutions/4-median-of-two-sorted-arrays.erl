-module(solution).
-export([findMedianSortedArrays/2]).

-spec merge(list(), list()) -> list().
merge([], L) -> L;
merge(L, []) -> L;
merge([H1|T1], [H2|T2]) when H1 =< H2 -> [H1 | merge(T1, [H2|T2])];
merge([H1|T1], [H2|T2]) -> [H2 | merge([H1|T1], T2)].

-spec findMedianSortedArrays(list(), list()) -> float().
findMedianSortedArrays(Nums1, Nums2) ->
    Merged = merge(Nums1, Nums2),
    TotalLen = length(Merged),
    case TotalLen rem 2 of
        1 ->
            % Odd length: median is the middle element
            lists:nth((TotalLen + 1) div 2, Merged);
        0 ->
            % Even length: median is the average of the two middle elements
            Elem1 = lists:nth(TotalLen div 2, Merged),
            Elem2 = lists:nth(TotalLen div 2 + 1, Merged),
            (Elem1 + Elem2) / 2.0
    end.