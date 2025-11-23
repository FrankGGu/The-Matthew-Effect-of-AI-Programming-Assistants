-module(solution).
-export([minimize_the_difference/3]).

minimize_the_difference(Target, A, B) ->
    AList = lists:sort(A),
    BList = lists:sort(B),
    minimize(Target, AList, BList).

minimize(Target, A, B) ->
    minimize_helper(Target, A, B, 0, length(A), 0, length(B)).

minimize_helper(Target, A, B, AIndex, ALength, BIndex, BLength) ->
    case {AIndex < ALength, BIndex < BLength} of
        {false, _} -> abs(Target);
        {_, false} -> abs(Target);
        {true, true} ->
            AValue = lists:nth(AIndex + 1, A),
            BValue = lists:nth(BIndex + 1, B),
            Sum = AValue + BValue,
            case Sum of
                S when S < Target -> minimize_helper(Target, A, B, AIndex + 1, ALength, BIndex, BLength);
                S when S > Target -> minimize_helper(Target, A, B, AIndex, ALength, BIndex + 1, BLength);
                _ -> 0
            end
    end.