-module(faulty_keyboard).
-export([final_string/1]).

final_string(S) ->
    lists:foldl(fun(C, Acc) ->
        if
            C == $\i ->
                lists:reverse(Acc);
            true ->
                [C | Acc]
        end
    end, [], S).