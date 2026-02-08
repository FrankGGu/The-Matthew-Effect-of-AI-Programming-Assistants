-module(solution).
-export([length_of_last_word/1]).

length_of_last_word(S) ->
    lists:foldl(fun(Char, {Count, InWord}) ->
                    if
                        Char == 32 ->
                            {0, false};
                        true ->
                            {Count + 1, true}
                    end
                end, {0, false}, S),
    case lists:reverse(S) of
        [32 | _] -> 0;
        _ -> lists:foldl(fun(Char, Acc) ->
                            if
                                Char == 32 -> Acc;
                                true -> Acc + 1
                            end
                        end, 0, lists:reverse(S))
    end.