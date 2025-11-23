-module(solution).
-export([longest_substring/2]).

longest_substring(Str, K) ->
    longest_substring(Str, K, 0, 0, dict:new(), 0).

longest_substring(_, _, Left, Right, _Dict, MaxLen) when Right == length(Str) ->
    MaxLen;
longest_substring(Str, K, Left, Right, Dict, MaxLen) ->
    Char = string:at(Str, Right),
    Count = dict:fetch_or_default(Char, Dict, 0),
    NewDict = dict:store(Char, Count + 1, Dict),
    case Count + 1 of
        C when C == K ->
            NewMax = max(MaxLen, Right - Left + 1),
            longest_substring(Str, K, Left, Right + 1, NewDict, NewMax);
        _ ->
            if
                Count + 1 < K ->
                    longest_substring(Str, K, Left, Right + 1, NewDict, MaxLen);
                true ->
                    % Find the next position to move left
                    NewLeft = find_next_left(Str, K, Left, Right, NewDict),
                    longest_substring(Str, K, NewLeft, Right + 1, NewDict, MaxLen)
            end
    end.

find_next_left(_, _, Left, Right, Dict) ->
    find_next_left(Str, K, Left, Right, Dict, Left).

find_next_left(_, _, Left, Right, _, Left) ->
    Left;
find_next_left(Str, K, Left, Right, Dict, Pos) ->
    Char = string:at(Str, Pos),
    Count = dict:fetch(Char, Dict),
    if
        Count < K ->
            find_next_left(Str, K, Left, Right, Dict, Pos + 1);
        true ->
            Pos
    end.