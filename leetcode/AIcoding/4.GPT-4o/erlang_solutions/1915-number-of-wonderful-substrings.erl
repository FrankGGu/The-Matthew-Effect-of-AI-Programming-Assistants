-module(solution).
-export([wonderfulSubstrings/1]).

wonderfulSubstrings(S) ->
    Count = lists:foldl(fun(C, Acc) -> 
        maps:update_with(C, fun(X) -> X + 1 end, 1, Acc) 
    end, #{}, string:to_list(S)),
    wonderful_count(Count, 0, 0).

wonderful_count(Count, Acc, Res) ->
    case maps:to_list(Count) of
        [] -> Res + Acc;
        [{Key, Val} | Tail] ->
            NewAcc = Acc + Val,
            NewRes = wonderful_count(Tail, NewAcc, Res + (Acc - Val)),
            wonderful_count(Tail, NewAcc, NewRes)
    end.