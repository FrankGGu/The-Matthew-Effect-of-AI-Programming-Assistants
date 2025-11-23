-module(solution).
-export([extract_spell/1]).

extract_spell(S) ->
    extract_spell(S, []).

extract_spell([], Acc) ->
    lists:reverse(Acc);
extract_spell([H|T], Acc) ->
    case H of
        $a -> extract_spell(T, [a | Acc]);
        $b -> extract_spell(T, [b | Acc]);
        $c -> extract_spell(T, [c | Acc]);
        _ -> extract_spell(T, Acc)
    end.