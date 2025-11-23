-module(solution).
-export([concatenated_divisibility/2]).

concatenated_divisibility(Nums, K) ->
    Count = length(Nums),
    DP = maps:new(),
    DP1 = maps:put(0, 1, DP),
    Ans = helper(Nums, K, 0, 0, Count, DP1, 0),
    Ans.

helper([], _K, _Pos, _Mask, _Count, DP, Ans) ->
    Ans;
helper([Num | Rest], K, Pos, Mask, Count, DP, Ans) ->
    NewDP = maps:new(),
    {NewAns, NewDP1} = update_dp(DP, Num, K, Mask, Pos, Count, Ans, NewDP),
    NewDP2 = merge_dp(DP, NewDP1),
    helper(Rest, K, Pos + 1, Mask bor (1 bsl Pos), Count, NewDP2, NewAns).

update_dp(DP, Num, K, Mask, Pos, Count, Ans, NewDP) ->
    maps:fold(fun(Rem, Cnt, {AccAns, AccDP} ->
        NewRem = (Rem * pow10(digit_count(Num)) + Num) rem K,
        NewCnt = case maps:get(NewRem, AccDP, 0) of
            Val -> Val + Cnt
        end,
        NewAccDP = maps:put(NewRem, NewCnt, AccDP),
        case (Mask band ((1 bsl Count) - 1)) == ((1 bsl Count) - 1) andalso NewRem == 0 of
            true -> {AccAns + Cnt, NewAccDP};
            false -> {AccAns, NewAccDP}
        end
    end, {Ans, NewDP}, DP).

merge_dp(DP1, DP2) ->
    maps:fold(fun(Rem, Cnt, Acc) ->
        case maps:get(Rem, Acc, 0) of
            Val -> maps:put(Rem, Val + Cnt, Acc)
        end
    end, DP1, DP2).

digit_count(0) -> 1;
digit_count(N) -> digit_count(N, 0).

digit_count(0, Count) -> Count;
digit_count(N, Count) -> digit_count(N div 10, Count + 1).

pow10(0) -> 1;
pow10(N) -> 10 * pow10(N - 1).