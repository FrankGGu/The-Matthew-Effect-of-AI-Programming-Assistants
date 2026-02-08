-module(solution).
-export([are_numbers_ascending/1]).

are_numbers_ascending(S) ->
    Words = string:tokens(S, " "),
    Numbers = lists:filtermap(
        fun(Word) ->
            try
                {ok, N} = string:to_integer(Word),
                {true, N}
            catch
                _:_ ->
                    false
            end
        end,
        Words
    ),
    are_ascending(Numbers, -1).

are_ascending([], _) ->
    true;
are_ascending([H|T], Prev) ->
    if
        H > Prev ->
            are_ascending(T, H);
        true ->
            false
    end.