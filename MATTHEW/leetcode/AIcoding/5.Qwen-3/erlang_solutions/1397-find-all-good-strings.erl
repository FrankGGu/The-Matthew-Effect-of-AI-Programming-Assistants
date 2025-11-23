-module(solution).
-export([countGoodStrings/2]).

countGoodStrings(Num, Target) ->
    countGoodStrings(Num, Target, 0, 0, 0).

countGoodStrings(_, _, _, _, Count) when Count > Num -> 0;
countGoodStrings(_, _, _, _, Count) when Count < 0 -> 0;
countGoodStrings(Num, Target, Pos, Current, Count) ->
    if
        Pos == length(Target) ->
            case Current of
                C when C >= Num -> 1;
                _ -> 0
            end;
        true ->
            Char = lists:nth(Pos + 1, Target),
            case Char of
                $a ->
                    countGoodStrings(Num, Target, Pos + 1, Current + 1, Count);
                $b ->
                    countGoodStrings(Num, Target, Pos + 1, Current, Count + 1);
                _ ->
                    countGoodStrings(Num, Target, Pos + 1, Current, Count)
            end
    end.