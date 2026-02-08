-module(solution).
-export([get_lucky/2]).

get_lucky(S, K) ->
    InitialNumStr = lists:flatmap(fun(Char) ->
                                        Pos = Char - $a + 1,
                                        integer_to_list(Pos)
                                end, S),

    apply_operations(InitialNumStr, K).

apply_operations(NumStr, 0) ->
    list_to_integer(NumStr);
apply_operations(NumStr, K) ->
    Sum = lists:foldl(fun(DigitChar, Acc) ->
                            Acc + (DigitChar - $0)
                    end, 0, NumStr),
    apply_operations(integer_to_list(Sum), K - 1).