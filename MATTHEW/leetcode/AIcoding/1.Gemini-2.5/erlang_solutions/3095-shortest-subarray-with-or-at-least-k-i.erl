-module(solution).
-export([shortest_subarray_with_or_at_least_k/2]).

shortest_subarray_with_or_at_least_k(Nums, K) ->
    N = length(Nums),
    MinLen = solve(Nums, K, 0, N, [], float('infinity')),
    if MinLen == float('infinity') -> -1;
       true -> MinLen
    end.

solve(Nums, K, RightIdx, N, CurrentORStates, MinLen) when RightIdx < N ->
    Num = lists:nth(RightIdx + 1, Nums),

    NextORStates = [{Num, RightIdx}] ++ 
                   [ {PrevOR bor Num, StartIdx} || {PrevOR, StartIdx} <- CurrentORStates ],

    SortedNextORStates = lists:sort(fun({_OR1, SI1}, {_OR2, SI2}) -> SI1 < SI2 end, NextORStates),

    NewCurrentORStates = consolidate_or_states(SortedNextORStates, [], -1),

    UpdatedMinLen = update_min_len(NewCurrentORStates, K, RightIdx, MinLen),

    solve(Nums, K, RightIdx + 1, N, NewCurrentORStates, UpdatedMinLen);

solve(_Nums, _K, _RightIdx, _N, _CurrentORStates, MinLen) ->
    MinLen.

consolidate_or_states([], Acc, _PrevORValAdded) ->
    lists:reverse(Acc);
consolidate_or_states([{OR_val, StartIdx} | Rest], Acc, PrevORValAdded) ->
    if OR_val =/= PrevORValAdded ->
        consolidate_or_states(Rest, [{OR_val, StartIdx} | Acc], OR_val);
    else
        consolidate_or_states(Rest, Acc, PrevORValAdded)
    end.

update_min_len([], _K, _RightIdx, MinLen) ->
    MinLen;
update_min_len([{OR_val, StartIdx} | Rest], K, RightIdx, MinLen) ->
    CurrentMinLen = 
        if OR_val >= K -> 
            min(MinLen, RightIdx - StartIdx + 1);
        true -> 
            MinLen
        end,
    update_min_len(Rest, K, RightIdx, CurrentMinLen).