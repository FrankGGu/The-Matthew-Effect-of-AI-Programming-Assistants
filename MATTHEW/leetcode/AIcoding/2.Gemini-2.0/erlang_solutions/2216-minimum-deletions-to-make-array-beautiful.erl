-module(min_deletions).
-export([min_deletions/1]).

min_deletions(Nums) ->
    min_deletions_helper(Nums, 0).

min_deletions_helper([], Acc) ->
    Acc;
min_deletions_helper([_], Acc) ->
    Acc + 1;
min_deletions_helper([N1, N2 | Rest], Acc) ->
    case N1 rem 2 =:= 0 of
        true ->
            case N1 =:= N2 of
                true ->
                    min_deletions_helper(Rest, Acc + 1);
                false ->
                    min_deletions_helper(Rest, Acc)
            end;
        false ->
            min_deletions_helper([N2 | Rest], Acc + 1)
    end.