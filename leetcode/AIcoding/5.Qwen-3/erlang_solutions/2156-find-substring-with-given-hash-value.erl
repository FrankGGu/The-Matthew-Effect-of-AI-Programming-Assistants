-module(substring_with_given_hash_value).
-export([solve/2]).

solve(S, K) ->
    N = length(S),
    Base = 256,
    Mod = 1000000007,
    Hash = fun(I) -> hash(S, I, K, Base, Mod) end,
    Index = find_index(S, K, N, Base, Mod, Hash),
    string:substr(S, Index + 1, K).

hash(S, I, K, Base, Mod) ->
    H = 0,
    hash_loop(S, I, K, H, Base, Mod).

hash_loop(_, _, 0, Acc, _, _) ->
    Acc;
hash_loop(S, I, J, Acc, Base, Mod) ->
    Char = lists:nth(I, S),
    NewAcc = (Acc * Base + Char) rem Mod,
    hash_loop(S, I + 1, J - 1, NewAcc, Base, Mod).

find_index(S, K, N, Base, Mod, Hash) ->
    Target = Hash(0),
    MaxI = N - K,
    find_index_loop(S, K, N, Base, Mod, Hash, 0, Target, MaxI).

find_index_loop(_, _, _, _, _, _, I, Target, MaxI) when I > MaxI ->
    0;
find_index_loop(S, K, N, Base, Mod, Hash, I, Target, MaxI) ->
    CurrentHash = Hash(I),
    if
        CurrentHash == Target ->
            I;
        true ->
            find_index_loop(S, K, N, Base, Mod, Hash, I + 1, Target, MaxI)
    end.