-module(additive_number).
-export([is_additive_number/1]).

is_additive_number(S) ->
    is_additive_number(S, 0, []).

is_additive_number([], _Pos, [A, B]) ->
    true;
is_additive_number(S, Pos, [A, B]) ->
    case string:split(S, "", right) of
        {_, ""} ->
            false;
        {Next, Rest} ->
            C = list_to_integer(Next),
            if
                A + B == C ->
                    is_additive_number(Rest, Pos + length(Next), [B, C]);
                true ->
                    false
            end
    end;
is_additive_number(S, Pos, []) ->
    MaxLen = length(S) - 2,
    lists:foldl(
        fun(I, Acc) ->
            if
                Acc /= false ->
                    Acc;
                true ->
                    A = list_to_integer(string:substr(S, 1, I)),
                    case string:substr(S, I+1) of
                        "" -> false;
                        Sub ->
                            lists:foldl(
                                fun(J, Acc2) ->
                                    if
                                        Acc2 /= false ->
                                            Acc2;
                                        true ->
                                            B = list_to_integer(string:substr(Sub, 1, J)),
                                            if
                                                (I + J) >= length(S) ->
                                                    false;
                                                true ->
                                                    is_additive_number(string:substr(S, I+J+1), I+J+1, [A, B])
                                            end
                                    end
                                end,
                                false,
                                lists:seq(1, min(length(Sub), length(S) - I - 1))
                            )
                    end
            end
        end,
        false,
        lists:seq(1, Min(MaxLen, length(S) - 1))
    ).

Min(A, B) when A < B -> A;
Min(_, B) -> B.