-module(solution).
-export([compress/1]).

compress(Str) ->
    compress(Str, 0, 0, 0).

compress([], _, _, _) -> 0;
compress(Str, Start, Count, Length) ->
    case Start of
        0 -> compress(Str, 1, 1, 0);
        _ ->
            if
                Count > 1 -> 
                    Length1 = Length + 1 + length(integer_to_list(Count));
                    compress(Str, Start + 1, 1, Length1);
                true ->
                    compress(Str, Start + 1, Count + 1, Length)
            end
    end.

string_compression(Str) ->
    Length = compress(Str),
    Length.