-module(solution).
-export([check_ascending/1]).

check_ascending(S) ->
    Words = string:tokens(S, " "),
    {Result, _} = lists:foldl(
        fun(Word, {AccResult, PrevNum}) ->
            if AccResult == false ->
                {false, PrevNum};
            else
                try list_to_integer(Word) of
                    CurrentNum ->
                        if CurrentNum > PrevNum ->
                            {true, CurrentNum};
                        else
                            {false, PrevNum}
                        end;
                catch
                    error:_ ->
                        {true, PrevNum}
                end
            end
        end,
        {true, -1},
        Words
    ),
    Result.