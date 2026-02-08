-module(solution).
-export([maxProduct/1]).

is_palindrome(L) ->
    L == lists:reverse(L).

get_subsequence(S, Mask, N) ->
    get_subsequence_acc(S, Mask, 0, N, []).

get_subsequence_acc(_S, _Mask, N, N, Acc) ->
    lists:reverse(Acc);
get_subsequence_acc(S, Mask, CurrentIdx, N, Acc) ->
    Char = lists:nth(CurrentIdx + 1, S),
    if (Mask bsr CurrentIdx) band 1 == 1 ->
        get_subsequence_acc(S, Mask, CurrentIdx + 1, N, [Char | Acc]);
    true ->
        get_subsequence_acc(S, Mask, CurrentIdx + 1, N, Acc)
    end.

get_submasks(Mask) ->
    get_submasks_acc(Mask, Mask, []).

get_submasks_acc(_OriginalMask, 0, Acc) ->
    Acc;
get_submasks_acc(OriginalMask, CurrentSubmask, Acc) ->
    NewAcc = [CurrentSubmask | Acc],
    NextSubmask = (CurrentSubmask - 1) band OriginalMask,
    get_submasks_acc(OriginalMask, NextSubmask, NewAcc).

maxProduct(S) ->
    N = length(S),
    TotalMask = (1 bsl N) - 1,

    lists:foldl(fun(Mask1, CurrentMaxProd) ->
        P1 = get_subsequence(S, Mask1, N),
        Len1 = length(P1),
        if is_palindrome(P1) ->
            RemainingMask = TotalMask bxor Mask1,
            lists:foldl(fun(Mask2, InnerMaxProd) ->
                P2 = get_subsequence(S, Mask2, N),
                Len2 = length(P2),
                if is_palindrome(P2) ->
                    max(InnerMaxProd, Len1 * Len2);
                true ->
                    InnerMaxProd
                end
            end, CurrentMaxProd, get_submasks(RemainingMask));
        true ->
            CurrentMaxProd
        end
    end, 0, lists:seq(1, TotalMask)).