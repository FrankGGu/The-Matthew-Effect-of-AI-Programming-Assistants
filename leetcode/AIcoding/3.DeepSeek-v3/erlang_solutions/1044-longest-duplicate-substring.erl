-module(solution).
-export([longest_duplicate_substring/1]).

longest_duplicate_substring(S) ->
    N = length(S),
    Left = 1,
    Right = N - 1,
    Result = "",
    binary_search(S, Left, Right, Result).

binary_search(_S, Left, Right, Result) when Left > Right ->
    Result;
binary_search(S, Left, Right, Result) ->
    Mid = (Left + Right) div 2,
    case search(S, Mid) of
        {ok, Str} ->
            binary_search(S, Mid + 1, Right, Str);
        not_found ->
            binary_search(S, Left, Mid - 1, Result)
    end.

search(S, Len) ->
    N = length(S),
    Seen = sets:new(),
    search(S, Len, 1, N - Len + 1, Seen).

search(_S, _Len, Start, _End, _Seen) when Start > _End ->
    not_found;
search(S, Len, Start, End, Seen) ->
    Sub = lists:sublist(S, Start, Len),
    Hash = erlang:phash2(Sub),
    case sets:is_element(Hash, Seen) of
        true ->
            case check_duplicate(S, Sub, Start - 1) of
                true -> {ok, Sub};
                false -> search(S, Len, Start + 1, End, sets:add_element(Hash, Seen))
            end;
        false ->
            search(S, Len, Start + 1, End, sets:add_element(Hash, Seen))
    end.

check_duplicate(S, Sub, Start) ->
    N = length(Sub),
    case string:substr(S, Start + 1, N) of
        Sub -> true;
        _ -> false
    end.