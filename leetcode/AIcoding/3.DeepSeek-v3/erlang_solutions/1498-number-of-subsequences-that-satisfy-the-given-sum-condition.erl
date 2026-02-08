-module(solution).
-export([num_subseq/2]).

num_subseq(Nums, Target) ->
    Sorted = lists:sort(Nums),
    Len = length(Sorted),
    Precompute = precompute_pows(Len),
    num_subseq(Sorted, Target, 0, Len - 1, Precompute, 0).

precompute_pows(Len) ->
    Mod = 1000000007,
    Pows = lists:duplicate(Len + 1, 1),
    precompute_pows(1, Len, Mod, Pows).

precompute_pows(I, Len, Mod, Pows) when I =< Len ->
    Pow = (lists:nth(I, Pows) * 2) rem Mod,
    NewPows = lists:sublist(Pows, I) ++ [Pow | lists:nthtail(I + 1, Pows)],
    precompute_pows(I + 1, Len, Mod, NewPows);
precompute_pows(_, _, _, Pows) ->
    Pows.

num_subseq(Sorted, Target, Left, Right, Precompute, Res) when Left =< Right ->
    case lists:nth(Left + 1, Sorted) + lists:nth(Right + 1, Sorted) =< Target of
        true ->
            NewRes = (Res + lists:nth(Right - Left + 1, Precompute)) rem 1000000007,
            num_subseq(Sorted, Target, Left + 1, Right, Precompute, NewRes);
        false ->
            num_subseq(Sorted, Target, Left, Right - 1, Precompute, Res)
    end;
num_subseq(_, _, _, _, _, Res) ->
    Res.