-module(solution).
-export([is_global_and_local_inversions/1]).

is_global_and_local_inversions(P) ->
    case count_inversions(P, 0, length(P) - 1) of
        {Global, Local} when Global =:= Local -> true;
        _ -> false
    end.

count_inversions([], _, _) -> {0, 0};
count_inversions(P, Start, End) when Start < End ->
    Mid = (Start + End) div 2,
    {LGlobal, LLocal} = count_inversions(P, Start, Mid),
    {RGlobal, RLocal} = count_inversions(P, Mid + 1, End),
    {Global, Local} = merge_and_count(P, Start, Mid, End, LLocal + RLocal),
    {LGlobal + RGlobal + Global, Local}.

merge_and_count(P, Start, Mid, End, LLocal) ->
    Left = lists:sublist(P, Start, Mid - Start + 1),
    Right = lists:sublist(P, Mid + 1, End - Mid),
    {Global, Local} = merge(Left, Right, Start, P, LLocal, 0),
    {Global, Local}.

merge([], [], _, P, LLocal, Local) -> {0, Local + LLocal};
merge([H | T], Right, Start, P, LLocal, Local) when H =< hd(Right) ->
    merge(T, Right, Start + 1, P, LLocal, Local);
merge(Left, [H | T], Start, P, LLocal, Local) ->
    NewLocal = Local + length(Left),
    merge(Left, T, Start + 1, P, LLocal, NewLocal).