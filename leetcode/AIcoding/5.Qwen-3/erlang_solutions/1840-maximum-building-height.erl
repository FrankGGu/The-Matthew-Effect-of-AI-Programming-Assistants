-module(maximum_building_height).
-export([maxHeight/2]).

maxHeight(S, R) ->
    lists:reverse(lists:sort([{H, B} || {B, H} <- R] ++ S)).

maxHeight(S, R, Acc) ->
    case S of
        [] -> Acc;
        [H | T] ->
            NewAcc = lists:foldl(fun({B, H1}, A) ->
                                         if H >= H1 -> A;
                                            true -> [{B, H} | A]
                                         end
                                 end, [], R),
            maxHeight(T, NewAcc, Acc ++ NewAcc)
    end.

maxHeight(S, R) ->
    maxHeight(S, R, []).