-module(longest_duplicate_substring).
-export([longest_dup_substring/1]).

longest_dup_substring(S) ->
    N = length(S),
    {L, R} = {0, N - 1},
    {_, Result} = binary_search(S, L, R),
    substring(S, Result, length(Result)).

binary_search(S, L, R) ->
    case R >= L of
        false -> {0, ""};
        true ->
            Mid = (L + R) div 2,
            case find_duplicate(S, Mid) of
                false -> binary_search(S, L, Mid - 1);
                Start -> {Mid, Start}
            end
    end.

find_duplicate(S, Len) ->
    Base = 256,
    Mod = 10^9 + 7,
    Hash = 0,
    Power = math:pow(Base, Len - 1),
    Map = maps:new(),
    N = length(S),
    Find = fun(I, Acc) ->
        if I + Len > N -> Acc;
           true ->
               Hash = (Hash * Base + char_code(string:substr(S, I + 1, 1))) rem Mod,
               if I >= Len - 1 ->
                   Key = Hash,
                   case maps:is_key(Key, Acc) of
                       true ->
                           Prev = maps:get(Key, Acc),
                           if string:substr(S, Prev + 1, Len) == string:substr(S, I - Len + 2, Len) -> {true, Prev};
                              true -> Acc
                           end;
                       false ->
                           maps:put(Key, I - Len + 2, Acc)
                   end
               else
                   Acc
               end
        end
    end,
    case lists:foldl(Find, Map, lists:seq(1, N)) of
        {true, Start} -> Start;
        _ -> false
    end.

char_code(C) when is_list(C) -> char_code(lists:nth(1, C));
char_code(C) -> C.

substring(S, Start, Len) ->
    string:substr(S, Start + 1, Len).