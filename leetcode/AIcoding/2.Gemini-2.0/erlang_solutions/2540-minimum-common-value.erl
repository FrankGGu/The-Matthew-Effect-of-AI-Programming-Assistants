-module(minimum_common_value).
-export([minimum_common_value/2]).

minimum_common_value(Nums1, Nums2) ->
    minimum_common_value(Nums1, Nums2, undefined).

minimum_common_value([], _, Acc) ->
    Acc;
minimum_common_value(_, [], Acc) ->
    Acc;
minimum_common_value([H1|T1], Nums2, Acc) ->
    case lists:member(H1, Nums2) of
        true ->
            case Acc of
                undefined ->
                    minimum_common_value(T1, Nums2, H1);
                Val when H1 < Val ->
                    minimum_common_value(T1, Nums2, H1);
                _ ->
                    minimum_common_value(T1, Nums2, Acc)
            end;
        false ->
            minimum_common_value(T1, Nums2, Acc)
    end.