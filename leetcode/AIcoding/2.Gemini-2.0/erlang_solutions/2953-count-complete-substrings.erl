-module(count_complete_substrings).
-export([count_complete_substrings/2]).

count_complete_substrings(Word, K) ->
    count_complete_substrings(Word, K, 0).

count_complete_substrings(Word, K, Acc) ->
    Len = length(Word),
    count_complete_substrings(Word, K, 1, Len, Acc).

count_complete_substrings(_Word, _K, Len, MaxLen, Acc) when Len > MaxLen ->
    Acc;
count_complete_substrings(Word, K, Len, MaxLen, Acc) ->
    count_complete_substrings(Word, K, Len, 0, MaxLen, Acc).

count_complete_substrings(_Word, _K, _Len, Pos, MaxLen, Acc) when Pos > MaxLen - _Len + 1 ->
    count_complete_substrings(_Word, _K, _Len + 1, MaxLen, Acc);
count_complete_substrings(Word, K, Len, Pos, MaxLen, Acc) ->
    Sub = string:sub_string(Word, Pos, Len),
    case is_complete(Sub, K) of
        true ->
            count_complete_substrings(Word, K, Len, Pos + 1, MaxLen, Acc + 1);
        false ->
            count_complete_substrings(Word, K, Len, Pos + 1, MaxLen, Acc)
    end.

is_complete(Sub, K) ->
    Map = maps:new(),
    is_complete(Sub, K, Map).

is_complete("", _K, _Map) ->
    true;
is_complete(Sub, K, Map) ->
    [H|T] = string:to_list(Sub),
    Char = list_to_atom([H]),
    case maps:is_key(Char, Map) of
        true ->
            NewMap = maps:update(Char, maps:get(Char, Map) + 1, Map);
            is_complete(lists_to_binary(T), K, NewMap);
        false ->
            NewMap = maps:put(Char, 1, Map);
            is_complete(lists_to_binary(T), K, NewMap)
    end.

is_complete(Sub, K, Map) ->
    Len = length(maps:keys(Map)),
    case Len == 26 of
        true ->
            Values = maps:values(Map),
            is_complete(Values, K);
        false ->
            false
    end.

is_complete([], _K) ->
    true;
is_complete([H|T], K) ->
    case H == K of
        true ->
            is_complete(T, K);
        false ->
            false
    end.