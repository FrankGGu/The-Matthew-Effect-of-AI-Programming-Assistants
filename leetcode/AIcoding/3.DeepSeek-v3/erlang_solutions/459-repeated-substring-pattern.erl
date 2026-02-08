-spec repeated_substring_pattern(S :: unicode:unicode_binary()) -> boolean().
repeated_substring_pattern(S) ->
    Len = byte_size(S),
    lists:any(fun(N) ->
                Len rem N =:= 0 andalso
                binary:part(S, 0, N) =:= binary:part(S, N, N) andalso
                binary:copy(binary:part(S, 0, N), Len div N) =:= S
             end, lists:seq(1, Len div 2)).