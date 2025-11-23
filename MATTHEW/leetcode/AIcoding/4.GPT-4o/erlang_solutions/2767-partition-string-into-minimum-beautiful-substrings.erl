-module(solution).
-export([beautifulSubstrings/1]).

beautifulSubstrings(S) ->
    beautifulSubstrings(S, <<>>, 0).

beautifulSubstrings(<<>>, _Cur, Count) ->
    Count + (if _Cur =/= <<>> -> 1; true -> 0 end);
beautifulSubstrings(Str, Cur, Count) ->
    case Str of
        <<C:8, Rest/binary>> ->
            NewCur = <<Cur/binary, C>>,
            case is_beautiful(NewCur) of
                true -> beautifulSubstrings(Rest, <<>>, Count + 1);
                false -> beautifulSubstrings(Rest, NewCur, Count)
            end
    end.

is_beautiful(Substring) ->
    case Substring of
        <<>> -> false;
        _ ->
            UniqueChars = lists:usort(binary_to_list(Substring)),
            count_ones(Substring, UniqueChars) =:= 1
    end.

count_ones(Substring, UniqueChars) ->
    lists:sum(lists:map(fun(C) -> binary_to_list(Substring) -- [C] end, UniqueChars)).