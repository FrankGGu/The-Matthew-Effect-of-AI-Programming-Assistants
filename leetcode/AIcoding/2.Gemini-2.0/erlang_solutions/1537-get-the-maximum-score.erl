-module(max_score).
-export([max_score/1]).

max_score(Args) ->
    max_score(lists:nth(1, Args), lists:nth(2, Args)).

max_score(Nums1, Nums2) ->
    max_score(Nums1, Nums2, 0, 0, 0, 1000000007).

max_score(Nums1, Nums2, I, J, Sum, Mod) ->
    case {I >= length(Nums1), J >= length(Nums2)} of
        {true, true} ->
            Sum rem Mod;
        {true, false} ->
            max_score(Nums1, Nums2, I, J + 1, Sum + lists:nth(J + 1, Nums2), Mod);
        {false, true} ->
            max_score(Nums1, Nums2, I + 1, J, Sum + lists:nth(I + 1, Nums1), Mod);
        {false, false} ->
            case lists:nth(I + 1, Nums1) == lists:nth(J + 1, Nums2) of
                true ->
                    V = lists:nth(I + 1, Nums1);
                    Sum1 = sum(lists:nthtail(I + 1, Nums1), V, Mod);
                    Sum2 = sum(lists:nthtail(J + 1, Nums2), V, Mod);
                    max_score(Nums1, Nums2, length(Nums1), length(Nums2), (Sum + max(Sum1, Sum2)) rem Mod, Mod);
                false ->
                    case lists:nth(I + 1, Nums1) < lists:nth(J + 1, Nums2) of
                        true ->
                            max_score(Nums1, Nums2, I + 1, J, Sum + lists:nth(I + 1, Nums1), Mod);
                        false ->
                            max_score(Nums1, Nums2, I, J + 1, Sum + lists:nth(J + 1, Nums2), Mod)
                    end
            end
    end.

sum([], _, _) -> 0;
sum([H|T], V, Mod) ->
    case H == V of
        true ->
            H rem Mod;
        false ->
            (H rem Mod + sum(T, V, Mod)) rem Mod
    end.