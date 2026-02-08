-module(solution).
-export([isIdealPermutation/1]).

isIdealPermutation(Nums) ->
    N = length(Nums),
    if N < 3 ->
        true;
    true ->
        is_ideal_perm_helper(tl(tl(Nums)), hd(Nums), hd(tl(Nums)))
    end.

is_ideal_perm_helper([], _MaxPrefixSoFar, _PreviousElement) ->
    true;
is_ideal_perm_helper([CurrentElement | Rest], MaxPrefixSoFar, PreviousElement) ->
    if MaxPrefixSoFar > CurrentElement ->
        false;
    true ->
        is_ideal_perm_helper(Rest, max(MaxPrefixSoFar, PreviousElement), CurrentElement)
    end.