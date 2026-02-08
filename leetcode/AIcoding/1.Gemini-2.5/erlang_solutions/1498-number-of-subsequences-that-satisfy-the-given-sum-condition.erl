-module(solution).
-export([numSubseq/2]).

numSubseq(Nums, Target) ->
    SortedNums = lists:sort(Nums),
    N = length(SortedNums),

    Mod = 1000000007,
    Powers = precompute_powers(N, Mod),

    NumsArray = array:from_list(SortedNums),

    two_pointers(0, N - 1, NumsArray, Target, Powers, Mod, 0).

precompute_powers(N, Mod) ->
    Powers = array:new(),
    precompute_powers_loop(0, N, Mod, Powers).

precompute_powers_loop(K, N, Mod, AccPowers) when K < N ->
    Val = case K of
              0 -> 1;
              _ -> (array:get(K-1, AccPowers) * 2) rem Mod
          end,
    NewAccPowers = array:set(K, Val, AccPowers),
    precompute_powers_loop(K + 1, N, Mod, NewAccPowers);
precompute_powers_loop(_, _, _, AccPowers) ->
    AccPowers.

two_pointers(Left, Right, NumsArray, Target, Powers, Mod, Count) when Left =< Right ->
    NumLeft = array:get(Left, NumsArray),
    NumRight = array:get(Right, NumsArray),

    if
        NumLeft + NumRight =< Target ->
            PowerOf2 = array:get(Right - Left, Powers),
            NewCount = (Count + PowerOf2) rem Mod,
            two_pointers(Left + 1, Right, NumsArray, Target, Powers, Mod, NewCount);
        true ->
            two_pointers(Left, Right - 1, NumsArray, Target, Powers, Mod, Count)
    end;
two_pointers(_, _, _, _, _, _, Count) ->
    Count.