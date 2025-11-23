-module(solution).
-export([longest_continuous_substring/1]).

longest_continuous_substring(S) ->
    Length = string:length(S),
    longest(S, Length, 0, 0).

longest([], _, MaxLen, CurrentLen) -> max(MaxLen, CurrentLen);
longest([H | T], Length, MaxLen, CurrentLen) ->
    NewLen = if CurrentLen == 0 orelse H >= hd(T) -> CurrentLen + 1; true -> 1 end,
    longest(T, Length, max(MaxLen, NewLen), NewLen).