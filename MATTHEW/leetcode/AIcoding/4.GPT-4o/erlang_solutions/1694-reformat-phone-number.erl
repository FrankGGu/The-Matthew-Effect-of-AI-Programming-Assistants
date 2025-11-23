-module(solution).
-export([reformat/1]).

reformat(Phone) ->
    Digits = lists:filter(fun(C) -> C >= $0 andalso C =< $9 end, list_to_string(Phone)),
    Reformatted = reformat_digits(Digits, []),
    lists:reverse(Reformatted).

reformat_digits([], Acc) -> Acc;
reformat_digits(Digits, Acc) ->
    {Part, Rest} = lists:split(3, Digits),
    NewAcc = lists:reverse(Part) ++ Acc,
    case Rest of
        [] -> NewAcc;
        [Last] -> [Last | NewAcc];
        _ -> reformat_digits(Rest, [?- | NewAcc])
    end.