-module(find_all_duplicates_in_an_array).
-export([find_duplicates/1]).

find_duplicates(Nums) ->
    find_duplicates(Nums, dict:new(), []).

find_duplicates([], _Dict, Result) ->
    lists:reverse(Result);
find_duplicates([N | Rest], Dict, Result) ->
    case dict:is_key(N, Dict) of
        true ->
            find_duplicates(Rest, Dict, [N | Result]);
        false ->
            find_duplicates(Rest, dict:store(N, true, Dict), Result)
    end.