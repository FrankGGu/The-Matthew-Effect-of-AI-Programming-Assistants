-module(solution).
-export([maxSumDivThree/1]).

maxSumDivThree(Numbers) ->
    maxSumDivThree(Numbers, 0, 0, 0).

maxSumDivThree([], Sum, Mod0, Mod1) ->
    case Mod0 of
        0 -> Sum;
        _ -> Sum - Mod1
    end;
maxSumDivThree([H | T], Sum, Mod0, Mod1) ->
    NewSum = Sum + H,
    NewMod0 = (Mod0 + H) rem 3,
    NewMod1 = case Mod0 rem 3 of
                  0 -> Mod1;
                  1 -> lists:max([Mod1, (H rem 3) * (H > 0)]);
                  2 -> lists:max([Mod1, (H rem 3) * (H < 0)])
              end,
    maxSumDivThree(T, NewSum, NewMod0, NewMod1).