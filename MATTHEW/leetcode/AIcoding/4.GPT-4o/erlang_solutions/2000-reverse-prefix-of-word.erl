-module(solution).
-export([reverse_prefix/2]).

reverse_prefix(Word, Ch) ->
    case string:to_charlist(Word) of
        [] -> Word;
        List ->
            Prefix = lists:take_while(fun(C) -> C =/= Ch end, List),
            case lists:prefix(Prefix, List) of
                true -> Word;
                false ->
                    Suffix = lists:drop(length(Prefix), List),
                    ReversedPrefix = lists:reverse(Prefix),
                    lists:append(ReversedPrefix, Suffix)
            end
    end.