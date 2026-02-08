-module(rabbits_in_forest).
-export([num_rabbits/1]).

num_rabbits(R) ->
    num_rabbits(R, dict:new(), 0).

num_rabbits([], _Dict, Acc) ->
    Acc;
num_rabbits([H | T], Dict, Acc) ->
    case dict:is_key(H, Dict) of
        true ->
            NewAcc = Acc + 1,
            NewDict = dict:store(H, dict:fetch(H, Dict) - 1, Dict),
            num_rabbits(T, NewDict, NewAcc);
        false ->
            NewAcc = Acc + H + 1,
            NewDict = dict:store(H, H - 1, Dict),
            num_rabbits(T, NewDict, NewAcc)
    end.