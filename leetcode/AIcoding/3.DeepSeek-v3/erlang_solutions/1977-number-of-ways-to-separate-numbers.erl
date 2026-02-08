-module(solution).
-export([numberOfCombinations/1]).

numberOfCombinations(Str) ->
    N = length(Str),
    if
        N == 0 -> 0;
        true ->
            Num = list_to_integer(Str),
            if
                Num == 0 -> 0;
                true ->
                    DP = array:new([{size, N + 1}, {default, array:new([{size, N + 1}, {default, 0}])}]),
                    Prefix = array:new([{size, N + 1}, {default, array:new([{size, N + 1}, {default, 0}])}]),
                    array:set(1, array:set(1, 1, array:get(1, DP)), DP,
                    array:set(1, array:set(1, 1, array:get(1, Prefix))), Prefix,
                    LCP = lcp_array(Str),
                    Mod = 1000000007,
                    Ans = 0,
                    {Ans, _} = lists:foldl(fun(I, {Acc, _}) ->
                        {NewAcc, NewDP, NewPrefix} = process_I(I, N, Str, LCP, DP, Prefix, Mod),
                        {NewAcc, {NewDP, NewPrefix}}
                    end, {0, {DP, Prefix}}, lists:seq(2, N + 1)),
                    Ans
            end
    end.

lcp_array(Str) ->
    N = length(Str),
    LCP = array:new([{size, N + 1}, {default, array:new([{size, N + 1}, {default, 0}])}]),
    lists:foldl(fun(I, _) ->
        lists:foldl(fun(J, _) ->
            if
                I == 1 orelse J == 1 -> 
                    array:set(I, array:set(J, 0, array:get(I, LCP))), LCP;
                true ->
                    if
                        lists:nth(I - 1, Str) == lists:nth(J - 1, Str) ->
                            Val = array:get(I - 1, array:get(J - 1, LCP)) + 1,
                            array:set(I, array:set(J, Val, array:get(I, LCP))), LCP;
                        true ->
                            array:set(I, array:set(J, 0, array:get(I, LCP))), LCP
                    end
            end
        end, ok, lists:seq(1, N + 1))
    end, ok, lists:seq(1, N + 1)),
    LCP.

process_I(I, N, Str, LCP, DP, Prefix, Mod) ->
    {NewDP, NewPrefix} = lists:foldl(fun(J, {DPAcc, PrefixAcc}) ->
        if
            J > I -> {DPAcc, PrefixAcc};
            true ->
                if
                    lists:nth(J, Str) == $0 -> 
                        NewDPAcc = array:set(I, array:set(J, 0, array:get(I, DPAcc))), DPAcc,
                        NewPrefixAcc = array:set(I, array:set(J, array:get(I, array:get(J - 1, PrefixAcc)), array:get(I, PrefixAcc))), PrefixAcc,
                        {NewDPAcc, NewPrefixAcc};
                    true ->
                        MaxK = J - 1,
                        if
                            MaxK == 0 -> 
                                Val = 1,
                                NewDPAcc = array:set(I, array:set(J, Val, array:get(I, DPAcc))), DPAcc,
                                Sum = (array:get(I, array:get(J - 1, PrefixAcc)) + Val) rem Mod,
                                NewPrefixAcc = array:set(I, array:set(J, Sum, array:get(I, PrefixAcc))), PrefixAcc,
                                {NewDPAcc, NewPrefixAcc};
                            true ->
                                K = find_k(J, I, Str, LCP),
                                if
                                    K == 0 -> 
                                        Val = array:get(J - 1, array:get(MaxK, PrefixAcc)),
                                        NewDPAcc = array:set(I, array:set(J, Val, array:get(I, DPAcc))), DPAcc,
                                        Sum = (array:get(I, array:get(J - 1, PrefixAcc)) + Val) rem Mod,
                                        NewPrefixAcc = array:set(I, array:set(J, Sum, array:get(I, PrefixAcc))), PrefixAcc,
                                        {NewDPAcc, NewPrefixAcc};
                                    true ->
                                        Val1 = array:get(J - 1, array:get(MaxK, PrefixAcc)),
                                        Val2 = array:get(J - 1, array:get(K - 1, PrefixAcc)),
                                        Val = (Val1 - Val2 + Mod) rem Mod,
                                        NewDPAcc = array:set(I, array:set(J, Val, array:get(I, DPAcc))), DPAcc,
                                        Sum = (array:get(I, array:get(J - 1, PrefixAcc)) + Val) rem Mod,
                                        NewPrefixAcc = array:set(I, array:set(J, Sum, array:get(I, PrefixAcc))), PrefixAcc,
                                        {NewDPAcc, NewPrefixAcc}
                                end
                        end
                end
        end
    end, {DP, Prefix}, lists:seq(1, I)),
    Ans = array:get(I, array:get(I, NewDP)),
    {Ans, NewDP, NewPrefix}.

find_k(J, I, Str, LCP) ->
    Len = I - J + 1,
    K1 = J - 1,
    if
        K1 < Len -> 0;
        true ->
            Common = array:get(J, array:get(J + Len, LCP)),
            if
                Common >= Len -> K1;
                true ->
                    if
                        lists:nth(J + Common, Str) > lists:nth(J + Len + Common, Str) -> K1;
                        true -> J - Len
                    end
            end
    end.