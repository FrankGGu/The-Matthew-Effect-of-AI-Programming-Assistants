-module(merge_triplets).
-export([merge_triplets/2]).

merge_triplets(Triplets, Target) ->
    merge_triplets(Triplets, Target, [false, false, false]).

merge_triplets([], _, [true, true, true]) ->
    true;
merge_triplets([], _, _) ->
    false;
merge_triplets([Triplet | Rest], Target, [HasI, HasJ, HasK]) ->
    [Ti, Tj, Tk] = Triplet,
    [TargetI, TargetJ, TargetK] = Target,
    case Ti =< TargetI and Tj =< TargetJ and Tk =< TargetK of
        true ->
            NewHasI = HasI or (Ti =:= TargetI),
            NewHasJ = HasJ or (Tj =:= TargetJ),
            NewHasK = HasK or (Tk =:= TargetK),
            merge_triplets(Rest, Target, [NewHasI, NewHasJ, NewHasK]);
        false ->
            merge_triplets(Rest, Target, [HasI, HasJ, HasK])
    end.