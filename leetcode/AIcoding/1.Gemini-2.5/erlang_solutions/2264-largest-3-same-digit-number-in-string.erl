-module(solution).
-export([largestGoodInteger/1]).

largestGoodInteger(Num) ->
    NumList = string:to_list(Num),
    ResultList = find_good_list(NumList, []),
    string:from_list(ResultList).

find_good_list(List, CurrentMaxGood) ->
    case List of
        [C1, C2, C3 | Rest] ->
            NewMaxGood =
                if C1 == C2 andalso C2 == C3 ->
                    GoodNumStr = [C1, C2, C3],
                    if CurrentMaxGood == [] orelse GoodNumStr > CurrentMaxGood ->
                        GoodNumStr;
                    true ->
                        CurrentMaxGood
                    end;
                true ->
                    CurrentMaxGood
                end,
            find_good_list([C2, C3 | Rest], NewMaxGood);
        _ ->
            CurrentMaxGood
    end.