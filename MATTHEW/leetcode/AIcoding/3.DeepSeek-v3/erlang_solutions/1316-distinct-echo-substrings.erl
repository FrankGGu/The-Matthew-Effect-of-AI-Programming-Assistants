-module(distinct_echo_substrings).
-export([distinct_echo_substrings/1]).

distinct_echo_substrings(Text) ->
    N = length(Text),
    Seen = sets:new(),
    lists:foldl(
        fun(Len, Acc) ->
            lists:foldl(
                fun(I, InnerAcc) ->
                    if
                        I + 2 * Len - 1 > N -> InnerAcc;
                        true ->
                            Sub1 = string:substr(Text, I, Len),
                            Sub2 = string:substr(Text, I + Len, Len),
                            case Sub1 == Sub2 of
                                true ->
                                    case sets:is_element(Sub1, Seen) of
                                        false ->
                                            sets:add_element(Sub1, Seen),
                                            InnerAcc + 1;
                                        true ->
                                            InnerAcc
                                    end;
                                false ->
                                    InnerAcc
                            end
                    end
                end,
                Acc,
                lists:seq(1, N)
            )
        end,
        0,
        lists:seq(1, N div 2)
    ).