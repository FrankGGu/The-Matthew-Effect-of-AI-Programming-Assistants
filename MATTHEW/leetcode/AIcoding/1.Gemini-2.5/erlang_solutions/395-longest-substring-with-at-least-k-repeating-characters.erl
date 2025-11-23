-module(solution).
-export([longestSubstring/2]).

longestSubstring(S, K) ->
    Len = length(S),
    if
        Len == 0 -> 0;
        K == 1 -> Len;
        Len < K -> 0;
        true ->
            FreqMap = lists:foldl(fun(Char, Acc) ->
                                        maps:update_with(Char, fun(Count) -> Count + 1 end, 1, Acc)
                                end, #{}, S),

            InvalidChars = maps:fold(fun(Char, Count, Acc) ->
                                         if
                                             Count < K -> [Char | Acc];
                                             true -> Acc
                                         end
                                     end, [], FreqMap),

            if
                InvalidChars == [] ->
                    Len;
                true ->
                    Substrings = string:tokens(S, InvalidChars),
                    lists:foldl(fun(Sub, MaxLen) ->
                                    max(MaxLen, longestSubstring(Sub, K))
                                end, 0, Substrings)
            end
    end.