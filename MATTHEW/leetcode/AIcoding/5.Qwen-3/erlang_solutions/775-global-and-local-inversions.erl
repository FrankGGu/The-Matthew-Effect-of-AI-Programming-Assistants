-module(solution).
-export([is_ideal_permutation/1]).

is_ideal_permutation(Permutation) ->
    is_ideal_permutation(Permutation, 0, 0).

is_ideal_permutation([], _, _) ->
    true;
is_ideal_permutation([H | T], Index, Local) ->
    if
        H =/= Index ->
            case abs(H - Index) > 1 of
                true -> false;
                _ -> is_ideal_permutation(T, Index + 1, Local + (if H < Index -> 1; true -> 0 end))
            end;
        true ->
            is_ideal_permutation(T, Index + 1, Local)
    end.