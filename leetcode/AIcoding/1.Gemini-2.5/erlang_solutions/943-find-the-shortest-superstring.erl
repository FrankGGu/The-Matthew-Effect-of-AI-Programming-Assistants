-module(solution).
-export([shortestSuperstring/1]).

overlap(S1, S2) ->
    Len1 = length(S1),
    Len2 = length(S2),
    overlap_loop(S1, S2, Len1, Len2, min(Len1, Len2)).

overlap_loop(_S1, _S2, _Len1, _Len2, K) when K < 1 ->
    0;
overlap_loop(S1, S2, Len1, Len2, K) ->
    Suffix1 = lists:nthtail(Len1 - K, S1),
    Prefix2 = lists:sublist(S2, K),
    if Suffix1 == Prefix2 ->
        K;
    true ->
        overlap_loop(S1, S2, Len1, Len2, K - 1)
    end.

shortestSuperstring(Words) ->
    N = length(Words),
    WordsArray = array:from_list(Words),

    OverlapMatrix = array:new({size, N*N}, {default, 0}),
    OverlapMatrix1 = lists:foldl(fun(I, AccMatrix) ->
        S1 = array:get(I, WordsArray),
        lists:foldl(fun(J, AccMatrix2) ->
            S2 = array:get(J, WordsArray),
            OverlapVal = overlap(S1, S2),
            array:set(I*N + J, OverlapVal, AccMatrix2)
        end, AccMatrix, lists:seq(0, N-1))
    end, OverlapMatrix, lists:seq(0, N-1)),

    MaxMask = 1 bsl N,
    Infinity = 1000000000,

    DP = array:new({size, MaxMask * N}, {default, Infinity}),
    Parent = array:new({size, MaxMask * N}, {default, -1}),

    DP1 = lists:foldl(fun(I, AccDP) ->
        S = array:get(I, WordsArray),
        Mask = 1 bsl I,
        array:set(Mask * N + I, length(S), AccDP)
    end, DP, lists:seq(0, N-1)),

    {FinalDP, FinalParent} = dp_loop(1, MaxMask - 1, N, OverlapMatrix1, WordsArray, DP1, Parent, Infinity),

    MinLen = Infinity,
    LastIdx = -1,
    {MinLenFinal, LastIdxFinal} = lists:foldl(fun(I, {CurrentMinLen, CurrentLastIdx}) ->
        Mask = MaxMask - 1,
        Len = array:get(Mask * N + I, FinalDP),
        if Len < CurrentMinLen ->
            {Len, I};
        true ->
            {CurrentMinLen, CurrentLastIdx}
        end
    end, {MinLen, LastIdx}, lists:seq(0, N-1)),

    Path = reconstruct_path(MaxMask - 1, LastIdxFinal, N, FinalParent, []),

    build_superstring(Path, N, WordsArray, OverlapMatrix1).

dp_loop(Mask, MaxMaskVal, N, OverlapMatrix, WordsArray, DP, Parent, Infinity) when Mask > MaxMaskVal ->
    {DP, Parent};
dp_loop(Mask, MaxMaskVal, N, OverlapMatrix, WordsArray, DP, Parent, Infinity) ->
    {NewDP, NewParent} = lists:foldl(fun(I, {AccDP, AccParent}) ->
        if (Mask band (1 bsl I)) == 0 ->
            {AccDP, AccParent};
        true ->
            lists:foldl(fun(J, {AccDP2, AccParent2}) ->
                if I == J ->
                    {AccDP2, AccParent2};
                (Mask band (1 bsl J)) == 0 ->
                    {AccDP2, AccParent2};
                true ->
                    PrevMask = Mask bxor (1 bsl I),
                    PrevLen = array:get(PrevMask * N + J, AccDP2),
                    if PrevLen == Infinity ->
                        {AccDP2, AccParent2};
                    true ->
                        OverlapVal = array:get(J*N + I, OverlapMatrix),
                        S_I = array:get(I, WordsArray),
                        CurrentLen = PrevLen + length(S_I) - OverlapVal,

                        ExistingLen = array:get(Mask * N + I, AccDP2),
                        if CurrentLen < ExistingLen ->
                            NewAccDP = array:set(Mask * N + I, CurrentLen, AccDP2),
                            NewAccParent = array:set(Mask * N + I, J, AccParent2),
                            {NewAccDP, NewAccParent};
                        true ->
                            {AccDP2, AccParent2}
                        end
                    end
                end
            end, {AccDP, AccParent}, lists:seq(0, N-1))
        end
    end, {DP, Parent}, lists:seq(0, N-1)),
    dp_loop(Mask + 1, MaxMaskVal, N, OverlapMatrix, WordsArray, NewDP, NewParent, Infinity).

reconstruct_path(Mask, LastIdx, N, Parent, AccPath) ->
    if Mask == 0 ->
        lists:reverse(AccPath);
    true ->
        PrevIdx = array:get(Mask * N + LastIdx, Parent),
        NewMask = Mask bxor (1 bsl LastIdx),
        reconstruct_path(NewMask, PrevIdx, N, Parent, [LastIdx | AccPath])
    end.

build_superstring([FirstIdx | RestPath], N, WordsArray, OverlapMatrix) ->
    Superstring = array:get(FirstIdx, WordsArray),
    build_superstring_loop(RestPath, Superstring, N, WordsArray, OverlapMatrix, FirstIdx).

build_superstring_loop([], Superstring, _N, _WordsArray, _OverlapMatrix, _PrevIdx) ->
    Superstring;
build_superstring_loop([CurrentIdx | RestPath], CurrentSuperstring, N, WordsArray, OverlapMatrix, PrevIdx) ->
    CurrentWord = array:get(CurrentIdx, WordsArray),
    OverlapVal = array:get(PrevIdx * N + CurrentIdx, OverlapMatrix),

    SuffixToAppend = lists:nthtail(OverlapVal, CurrentWord),
    NewSuperstring = CurrentSuperstring ++ SuffixToAppend,
    build_superstring_loop(RestPath, NewSuperstring, N, WordsArray, OverlapMatrix, CurrentIdx).