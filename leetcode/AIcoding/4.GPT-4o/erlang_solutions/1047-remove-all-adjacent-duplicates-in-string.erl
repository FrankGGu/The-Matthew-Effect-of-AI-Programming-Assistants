-module(solution).
-export([remove_duplicates/1]).

remove_duplicates(S) ->
    remove_duplicates_helper(S, []).

remove_duplicates_helper([], Acc) ->
    lists:reverse(Acc);
remove_duplicates_helper([H | T], Acc) ->
    case Acc of
        [] -> remove_duplicates_helper(T, [H]);
        [Last | _] when Last =:= H -> remove_duplicates_helper(T, Acc);
        _ -> remove_duplicates_helper(T, [H | Acc])
    end.