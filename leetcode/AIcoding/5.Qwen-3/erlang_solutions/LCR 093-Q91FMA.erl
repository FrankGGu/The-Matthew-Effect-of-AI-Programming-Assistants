-module(fibonacci_subsequence).
-export([len_longest_fibish/1]).

len_longest_fibish(Numbers) ->
    len_longest_fibish(Numbers, 0, dict:new()).

len_longest_fibish([], _Index, _Dict) ->
    0;
len_longest_fibish([N | Rest], Index, Dict) ->
    MaxLen = 2,
    lists:foldl(fun(I, Acc) ->
        case dict:find({I, N}, Dict) of
            {ok, Len} ->
                if Len + 1 > Acc -> Len + 1;
                   true -> Acc
                end;
            error ->
                Acc
        end
    end, MaxLen, lists:seq(0, Index - 1)),
    NewDict = lists:foldl(fun(I, D) ->
        case dict:find({I, N}, D) of
            {ok, Len} ->
                dict:store({I, N}, max(Len, 2), D);
            error ->
                dict:store({I, N}, 2, D)
        end
    end, Dict, lists:seq(0, Index - 1)),
    MaxLen = len_longest_fibish(Rest, Index + 1, NewDict),
    MaxLen.