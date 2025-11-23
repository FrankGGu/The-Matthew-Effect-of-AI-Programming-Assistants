-module(solution).
-export([minNumberOfStrings/2]).

minNumberOfStrings(Target, Strings) ->
    {ok, Frequency} = lists:foldl(fun(String, Acc) ->
        Freq = lists:foldl(fun(Char, F) ->
            maps:update_with(Char, fun(Count) -> Count + 1 end, fun() -> 1 end, F)
        end, Acc, String),
        Freq
    end, #{}, Strings),
    min_count(Frequency, Target).

min_count(_, []) -> 0;
min_count(Frequency, [H | T]) ->
    case maps:is_key(H, Frequency) of
        true -> 
            Count = maps:get(H, Frequency),
            Remaining = lists:filter(fun(X) -> X /= H end, T),
            1 + min_count(Frequency, Remaining);
        false -> 
            infinity
    end.

infinity -> 9999999.