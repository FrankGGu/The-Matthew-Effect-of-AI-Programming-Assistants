-module(solution).
-export([longest_dup_substring/1]).

longest_dup_substring(S) ->
    N = length(S),
    if N < 2 ->
        "";
    true ->
        Base = 29,
        Modulus = 1_000_000_007,

        ArrayS = array:from_list(S),

        {BestLen, BestStart0Idx} = binary_search(1, N - 1, N, ArrayS, Base, Modulus),

        if BestLen == 0 ->
            "";
        true ->
            lists:sublist(S, BestStart0Idx + 1, BestLen)
        end
    end.

binary_search(Low, High, _N, _ArrayS, _Base, _Modulus, BestLen, BestStart0Idx) when Low > High ->
    {BestLen, BestStart0Idx};
binary_search(Low, High, N, ArrayS, Base, Modulus, CurrentBestLen, CurrentBestStart0Idx) ->
    Mid = Low + (High - Low) div 2,
    case check(Mid, N, ArrayS, Base, Modulus) of
        {ok, StartIndex0Idx} ->
            binary_search(Mid + 1, High, N, ArrayS, Base, Modulus, Mid, StartIndex0Idx);
        false ->
            binary_search(Low, Mid - 1, N, ArrayS, Base, Modulus, CurrentBestLen, CurrentBestStart0Idx)
    end.

check(L, N, ArrayS, Base, Modulus) ->
    if L == 0 ->
        {ok, 0};
    true ->
        PowerLMinus1 = pow(Base, L - 1, Modulus),

        InitialSublist = [array:get(I, ArrayS) || I <- lists:seq(0, L - 1)],
        InitialHash = calculate_hash(InitialSublist, Base, Modulus),

        Hashes = maps:put(InitialHash, 0, maps:new()),

        check_rolling(L, N, ArrayS, Base, Modulus, PowerLMinus1, InitialHash, 1, Hashes)
    end.

check_rolling(L, N, ArrayS, Base, Modulus, PowerLMinus1, CurrentHash, CurrentStart0Idx, Hashes) when CurrentStart0Idx > N - L ->
    false;
check_rolling(L, N, ArrayS, Base, Modulus, PowerLMinus1, CurrentHash, CurrentStart0Idx, Hashes) ->
    PrevCharVal = (array:get(CurrentStart0Idx - 1, ArrayS) - $a + 1),
    NextCharVal = (array:get(CurrentStart0Idx + L - 1, ArrayS) - $a + 1),

    HashToRemove = (PrevCharVal * PowerLMinus1) rem Modulus,
    HashAfterRemove = (CurrentHash - HashToRemove + Modulus) rem Modulus,

    NewHash = (HashAfterRemove * Base + NextCharVal) rem Modulus,

    case maps:find(NewHash, Hashes) of
        {ok, _ExistingStartIndex0Idx} ->
            {ok, CurrentStart0Idx};
        error ->
            NewHashes = maps:put(NewHash, CurrentStart0Idx, Hashes),
            check_rolling(L, N, ArrayS, Base, Modulus, PowerLMinus1, NewHash, CurrentStart0Idx + 1, NewHashes)
    end.

calculate_hash(Sublist, Base, Modulus) ->
    lists:foldl(fun(Char, Acc) ->
        (Acc * Base + (Char - $a + 1)) rem Modulus
    end, 0, Sublist).

pow(_Base, 0, _Modulus) -> 1;
pow(Base, Exp, Modulus) ->
    if Exp rem 2 == 0 ->
        Half = pow(Base, Exp div 2, Modulus),
        (Half * Half) rem Modulus;
    true ->
        (Base * pow(Base, Exp - 1, Modulus)) rem Modulus
    end.