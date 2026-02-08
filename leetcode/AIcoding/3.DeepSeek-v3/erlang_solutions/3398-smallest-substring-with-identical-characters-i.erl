-module(solution).
-export([smallest_substring/1]).

smallest_substring(S) ->
    case S of
        [] -> "";
        _ ->
            {MinLen, Start, _} = lists:foldl(
                fun(Char, {CurrentLen, CurrentStart, LastChar}) ->
                    if
                        Char == LastChar ->
                            NewLen = CurrentLen + 1,
                            {NewLen, CurrentStart, LastChar};
                        true ->
                            {1, length(S) - CurrentLen, Char}
                    end
                end,
                {1, 0, hd(S)},
                tl(S) ++ [hd(S)]
            ),
            string:sub_string(S, Start + 1, Start + MinLen)
    end.