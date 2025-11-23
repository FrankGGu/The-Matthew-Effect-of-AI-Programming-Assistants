-module(occurrences_after_bigram).
-export([findOcurrences/3]).

findOcurrences(Text, First, Second) ->
    Words = string:split(Text, " ", all),
    findOcurrences(Words, First, Second, []).

findOcurrences([], _, _, Acc) ->
    lists:reverse(Acc);
findOcurrences([W1, W2 | Rest], First, Second, Acc) ->
    case W1 == First andalso W2 == Second of
        true ->
            case Rest of
                [W3 | _] -> findOcurrences(Rest, First, Second, [W3 | Acc]);
                _ -> findOcurrences(Rest, First, Second, Acc)
            end;
        false ->
            findOcurrences([W2 | Rest], First, Second, Acc)
    end;
findOcurrences([_ | Rest], First, Second, Acc) ->
    findOcurrences(Rest, First, Second, Acc).