-module(solution).
-export([majority_element_ii/1]).

majority_element_ii(Nums) ->
    N = length(Nums),
    {Cand1, _, Cand2, _} = pass1(Nums, none, 0, none, 0),
    Threshold = N div 3,
    Result = [],
    Result1 = check_candidate(Nums, Cand1, Threshold, Result),
    Result2 = check_candidate(Nums, Cand2, Threshold, Result1, Cand1),
    Result2.

pass1([], Cand1, Cnt1, Cand2, Cnt2) ->
    {Cand1, Cnt1, Cand2, Cnt2};
pass1([H|T], Cand1, Cnt1, Cand2, Cnt2) ->
    if
        H == Cand1 ->
            pass1(T, Cand1, Cnt1 + 1, Cand2, Cnt2);
        H == Cand2 ->
            pass1(T, Cand1, Cnt1, Cand2, Cnt2 + 1);
        Cnt1 == 0 ->
            pass1(T, H, 1, Cand2, Cnt2);
        Cnt2 == 0 ->
            pass1(T, Cand1, Cnt1, H, 1);
        true ->
            pass1(T, Cand1, Cnt1 - 1, Cand2, Cnt2 - 1)
    end.

count_occurrences([], _Target) ->
    0;
count_occurrences([H|T], Target) ->
    if
        H == Target -> 1 + count_occurrences(T, Target);
        true -> count_occurrences(T, Target)
    end.

check_candidate(_Nums, none, _Threshold, Acc) ->
    Acc;
check_candidate(Nums, Cand, Threshold, Acc) ->
    ActualCount = count_occurrences(Nums, Cand),
    if
        ActualCount > Threshold ->
            [Cand | Acc];
        true ->
            Acc
    end.

check_candidate(_Nums, none, _Threshold, Acc, _OtherCand) ->
    Acc;
check_candidate(Nums, Cand, Threshold, Acc, OtherCand) ->
    if
        Cand == OtherCand ->
            Acc;
        true ->
            ActualCount = count_occurrences(Nums, Cand),
            if
                ActualCount > Threshold ->
                    [Cand | Acc];
                true ->
                    Acc
            end
    end.