-module(solution).
-export([count_characters/2]).

count_characters(Chars, Words) ->
    Count = lists:foldl(fun(Char, Acc) -> dict:update_counter(Char, 1, Acc) end, dict:new(), Chars),
    lists:foldl(fun(W, Acc) -> check_word(W, Count, Acc) end, 0, Words).

check_word([], _, Acc) -> Acc + 1;
check_word([H|T], Count, Acc) ->
    case dict:is_key(H, Count) of
        true ->
            case dict:fetch(H, Count) of
                0 -> Acc;
                N ->
                    case dict:is_key(H, dict:new()) of
                        false -> Acc;
                        true ->
                            NewCount = dict:update_counter(H, -1, Count),
                            check_word(T, NewCount, Acc)
                    end
            end;
        false -> Acc
    end.