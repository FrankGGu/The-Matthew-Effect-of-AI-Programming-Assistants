-module(solution).
-export([total_appeal/1]).

total_appeal(S) ->
    Length = string:length(S),
    Appeal = lists:foldl(fun(Char, {Index, Acc}) ->
        NewAcc = Acc + (Index + 1) * (Length - Index),
        {Index + 1, NewAcc}
    end, {1, 0}, string:to_list(S)),
    element(2, Appeal).