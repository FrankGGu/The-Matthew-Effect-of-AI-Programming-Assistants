-module(solution).
-export([smallest_substring/1]).

smallest_substring(Str) ->
    case string:to_list(Str) of
        [] -> "";
        Chars ->
            SmallestLength = lists:foldl(fun(Char, Acc) ->
                case lists:prefix([Char | Acc], Chars) of
                    true -> length([Char | Acc]);
                    false -> Acc
                end
            end, length(Chars), Chars),
            SmallestSubstring = lists:foldl(fun(Char, Acc) ->
                case lists:prefix([Char | Acc], Chars) of
                    true -> [Char | Acc];
                    false -> Acc
                end
            end, [], Chars),
            lists:sublist(SmallestSubstring, SmallestLength)
    end.