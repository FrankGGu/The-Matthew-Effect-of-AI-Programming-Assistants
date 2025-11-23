-module(solution).
-export([max_freq_substring/2]).

max_freq_substring(String, Length) ->
    {ok, Substrings} = lists:foldl(fun(_, Acc) -> [{string:substr(String, I, Length), I} || I <- lists:seq(1, string:length(String) - Length + 1)] ++ Acc end, [], lists:seq(1, Length)),
    CountMap = lists:foldl(fun(X, Acc) -> maps:update_with(X, fun(E) -> E + 1 end, 1, Acc) end, #{}, Substrings),
    case maps:to_list(CountMap) of
        [] -> 0;
        Pairs -> lists:max([V || {_, V} <- Pairs])
    end.