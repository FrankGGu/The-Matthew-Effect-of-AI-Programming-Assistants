-module(most_frequent_number_following_key_in_an_array).
-export([mostFrequent/2]).

mostFrequent(Keys, Num) ->
    mostFrequent(Keys, Num, 0, dict:new(), 0).

mostFrequent([], _, _, Dict, _) ->
    dict:to_list(Dict),
    lists:keysort(1, dict:to_list(Dict)),
    lists:last(dict:to_list(Dict)).

mostFrequent([Key | Rest], [Num | RestNum], Index, Dict, MaxCount) ->
    case Index of
        0 -> 
            mostFrequent(Rest, RestNum, Index + 1, Dict, MaxCount);
        _ ->
            if Key == Num ->
                case dict:is_key(Num, Dict) of
                    true ->
                        Count = dict:fetch(Num, Dict) + 1,
                        NewDict = dict:store(Num, Count, Dict),
                        case Count > MaxCount of
                            true -> mostFrequent(Rest, RestNum, Index + 1, NewDict, Count);
                            false -> mostFrequent(Rest, RestNum, Index + 1, NewDict, MaxCount)
                        end;
                    false ->
                        NewDict = dict:store(Num, 1, Dict),
                        case 1 > MaxCount of
                            true -> mostFrequent(Rest, RestNum, Index + 1, NewDict, 1);
                            false -> mostFrequent(Rest, RestNum, Index + 1, NewDict, MaxCount)
                        end
                end;
            true ->
                mostFrequent(Rest, RestNum, Index + 1, Dict, MaxCount)
            end
    end;

mostFrequent(_, _, _, Dict, MaxCount) ->
    lists:keyfind(MaxCount, 1, dict:to_list(Dict)).