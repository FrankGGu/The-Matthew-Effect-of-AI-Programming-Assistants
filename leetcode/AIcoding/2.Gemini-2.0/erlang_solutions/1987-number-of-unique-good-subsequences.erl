-module(unique_subsequences).
-export([num_subseq/1]).

num_subseq(BinaryString) ->
    num_subseq_helper(BinaryString, 0, 0, 0).

num_subseq_helper([], Ones, Zeros, Mod) ->
    if Zeros > 0 then
        (Ones + Zeros) rem Mod
    else
        Ones rem Mod
    end;
num_subseq_helper([H|T], Ones, Zeros, Mod) ->
    case H of
        $0 ->
            num_subseq_helper(T, Ones, (Ones + Zeros + 1) rem Mod, Mod);
        $1 ->
            num_subseq_helper(T, (Ones + Ones + Zeros + 1) rem Mod, Zeros, Mod)
    end.

num_subseq(S) ->
    num_subseq_helper(S, 0, 0, 1000000007).