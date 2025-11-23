-module(merge_triplets_to_form_target_triplet).
-export([canForm/2]).

canForm(Triplets, Target) ->
    canForm(Triplets, Target, 0, 0, 0).

canForm([], _, _, _, _) ->
    false;
canForm([H | T], Target, A, B, C) ->
    [A1, B1, C1] = H,
    case (A1 =< element(1, Target) andalso B1 =< element(2, Target) andalso C1 =< element(3, Target)) of
        true ->
            NewA = max(A, A1),
            NewB = max(B, B1),
            NewC = max(C, C1),
            if
                NewA == element(1, Target) andalso NewB == element(2, Target) andalso NewC == element(3, Target) ->
                    true;
                true ->
                    canForm(T, Target, NewA, NewB, NewC)
            end;
        false ->
            canForm(T, Target, A, B, C)
    end.