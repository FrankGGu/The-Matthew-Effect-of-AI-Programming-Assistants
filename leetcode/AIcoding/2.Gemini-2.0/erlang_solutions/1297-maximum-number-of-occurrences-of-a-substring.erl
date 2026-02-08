-module(max_occurrence).
-export([maxFreq/5]).

maxFreq(S, MaxLetters, MinSize, MaxSize, N) ->
    maxFreq(S, MaxLetters, MinSize, MaxSize, N, 0).

maxFreq(S, MaxLetters, MinSize, MaxSize, N, Acc) ->
    maxFreq(S, MaxLetters, MinSize, MaxSize, N, 1, Acc, #{}, []).

maxFreq(S, MaxLetters, MinSize, MaxSize, N, I, Acc, Map, Substrings) when I + MinSize - 1 =< N ->
    Sub = sub_string(S, I, MinSize),
    case valid_substring(Sub, MaxLetters) of
        true ->
            NewMap = maps:update_with(Sub, fun(V) -> V + 1 end, 1, Map),
            maxFreq(S, MaxLetters, MinSize, MaxSize, N, I + 1, max(Acc, maps:get(Sub, NewMap)), NewMap, [Sub | Substrings]);
        false ->
            maxFreq(S, MaxLetters, MinSize, MaxSize, N, I + 1, Acc, Map, Substrings)
    end;
maxFreq(_, _, _, _, _, _, Acc, _, _) ->
    Acc.

valid_substring(Sub, MaxLetters) ->
    valid_substring(Sub, MaxLetters, #{}, 0).

valid_substring(Sub, MaxLetters, CharMap, Count) ->
    valid_substring(Sub, MaxLetters, CharMap, 1, Count).

valid_substring(Sub, MaxLetters, CharMap, I, Count) when I =< size(Sub) ->
    Char = element(I, Sub),
    case maps:is_key(Char, CharMap) of
        true ->
            valid_substring(Sub, MaxLetters, CharMap, I + 1, Count);
        false ->
            NewCount = Count + 1,
            case NewCount =< MaxLetters of
                true ->
                    NewMap = maps:put(Char, 1, CharMap),
                    valid_substring(Sub, MaxLetters, NewMap, I + 1, NewCount);
                false ->
                    false
            end
    end;
valid_substring(_, MaxLetters, _, _, Count) ->
    true.