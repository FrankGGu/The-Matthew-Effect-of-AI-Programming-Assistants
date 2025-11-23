-module(palindromic_substrings).
-export([count_substrings/1]).

count_substrings(S) ->
    Count = 0,
    Len = erlang:length(S),
    lists:foldl(fun(I, Acc) ->
        {Count1, _} = expand(Acc, S, I, I),
        {Count2, _} = expand(Count1, S, I, I + 1),
        Count2
    end, 0, lists:seq(0, Len - 1)).

expand(Count, S, L, R) ->
    Len = erlang:length(S),
    case L >= 0 andalso R < Len of
        true ->
            case string:substr(S, L + 1, 1) == string:substr(S, R + 1, 1) of
                true -> expand(Count + 1, S, L - 1, R + 1);
                false -> {Count, 0}
            end;
        false ->
            {Count, 0}
    end.