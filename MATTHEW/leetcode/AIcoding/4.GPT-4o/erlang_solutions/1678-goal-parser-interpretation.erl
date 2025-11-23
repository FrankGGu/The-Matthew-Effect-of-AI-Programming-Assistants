-module(solution).
-export([interpret/1]).

interpret(S) ->
    interpret(S, []).

interpret([], Acc) ->
    lists:reverse(Acc);
interpret([H | T], Acc) ->
    case H of
        $G -> interpret(T, [<<"G">> | Acc]);
        $o -> interpret(T, [<<"o">> | Acc]);
        $a -> interpret(T, [<<"a">> | Acc]);
        $l -> interpret(T, [<<"l">> | Acc]);
        $P -> interpret(T, [<<"P">> | Acc]);
        $a -> interpret(T, [<<"a">> | Acc]);
        $r -> interpret(T, [<<"r">> | Acc]);
        $I -> interpret(T, [<<"I">> | Acc]);
        $n -> interpret(T, [<<"n">> | Acc]);
        $t -> interpret(T, [<<"t">> | Acc]);
        $e -> interpret(T, [<<"e">> | Acc]);
        $r -> interpret(T, [<<"r">> | Acc]);
        _ -> interpret(T, Acc)
    end.