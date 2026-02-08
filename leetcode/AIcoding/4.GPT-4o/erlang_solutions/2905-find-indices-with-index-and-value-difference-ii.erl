-module(solution).
-export([find_indices/2]).

find_indices(Nums, Target) ->
    find_indices_helper(Nums, Target, 0, []).

find_indices_helper([], _, _, Acc) ->
    lists:reverse(Acc);
find_indices_helper([H | T], Target, Index, Acc) ->
    case lists:foldl(fun(X, Acc1) -> 
        case H - X of 
            Target -> [{Index, lists:nth(Index + 1, [H | T])} | Acc1];
            _ -> Acc1
        end
    end, Acc, T) of
        Result when Result =/= Acc -> 
            find_indices_helper(T, Target, Index + 1, Result);
        Result -> 
            find_indices_helper(T, Target, Index + 1, Acc)
    end.