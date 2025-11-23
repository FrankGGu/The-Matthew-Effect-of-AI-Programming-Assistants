-module(form_smallest_number).
-export([form_smallest_number/2]).

form_smallest_number(Nums1, Nums2) ->
    Intersection = Nums1 -- (Nums1 -- Nums2),
    if Intersection /= [] ->
        lists:min(Intersection)
    else
        Min1 = lists:min(Nums1),
        Min2 = lists:min(Nums2),
        if Min1 < Min2 ->
            Min1 * 10 + Min2
        else
            Min2 * 10 + Min1
        end
    end.