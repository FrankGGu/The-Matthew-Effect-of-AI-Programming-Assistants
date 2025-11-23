-module(solution).
-export([are_almost_equal/2]).

are_almost_equal(S, T) ->
    case length(S) =:= length(T) of
        false -> false;
        true ->
            S_chars = lists:seq(0, length(S)-1),
            S_chars_list = lists:map(fun(I) -> string:substr(S, I+1, 1) end, S_chars),
            T_chars_list = lists:map(fun(I) -> string:substr(T, I+1, 1) end, S_chars),
            Diff = lists:foldl(fun({S_char, T_char}, Acc) ->
                                       if S_char =/= T_char -> Acc + 1;
                                          true -> Acc
                                       end
                               end, 0, lists:zip(S_chars_list, T_chars_list)),
            Diff =< 2.
    end.