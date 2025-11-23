-module(solution).
-export([find_the_longest_substring/1]).

find_the_longest_substring(S) ->
    Vowels = sets:from_list("aeiou"),
    State = 0,
    FirstPos = maps:from_list([{0, -1}]),
    {MaxLen, _, _} = lists:foldl(fun(Char, {Len, StateAcc, FirstPosAcc}) ->
        case sets:is_element(Char, Vowels) of
            true ->
                NewState = StateAcc bxor (1 bsl (Char - $a)),
                case maps:find(NewState, FirstPosAcc) of
                    {ok, Pos} ->
                        {max(Len, Char - Pos), NewState, FirstPosAcc};
                    error ->
                        {Len, NewState, maps:put(NewState, Char, FirstPosAcc)}
                end;
            false ->
                {Len, StateAcc, FirstPosAcc}
        end
    end, {0, State, FirstPos}, S),
    MaxLen.