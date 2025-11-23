-module(solution).
-export([countSubstrings/2]).

countSubstrings(S, K) ->
    count_sub(S, K, 0).

count_sub([], _K, Acc) ->
    Acc;
count_sub([_Char | RestS], K, Acc) ->
    NewAcc = count_sub_inner([_Char | RestS], K, maps:new(), Acc),
    count_sub(RestS, K, NewAcc).

count_sub_inner([], _K, _CurrentFreqMap, Acc) ->
    Acc;
count_sub_inner([Char | Rest], K, CurrentFreqMap, Acc) ->
    NewFreqMap = maps:update_with(Char, fun(Count) -> Count + 1 end, 1, CurrentFreqMap),

    IsGood = check_frequencies(NewFreqMap, K),
    NewAcc = if IsGood -> Acc + 1; true -> Acc end,

    count_sub_inner(Rest, K, NewFreqMap, NewAcc).

check_frequencies(FreqMap, K) ->
    maps:fold(fun(_Char, Count, IsGoodAcc) ->
        IsGoodAcc andalso (Count >= K)
    end, true, FreqMap).