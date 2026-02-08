-module(merge_k_sorted_lists).
-export([merge/1]).

merge(Lists) ->
    merge(Lists, []).

merge([], Result) ->
    lists:reverse(Result);
merge([[] | Rest], Result) ->
    merge(Rest, Result);
merge([[H | T] | Rest], Result) ->
    merge(Rest, [H | Result] ++ lists:sort([T | lists:tl(Rest)])).

merge([], _, _) ->
    [];
merge([[] | _], _, _) ->
    [];
merge([H | T], Acc, Min) ->
    case H of
        [HVal | HRest] when HVal < Min ->
            merge(T, [HVal | Acc], HVal);
        _ ->
            merge(T, Acc, Min)
    end.