-module(total_characters_ii).
-export([solve/1]).

solve(S) ->
    lists:foldl(fun(C, Acc) ->
        case C of
            $a -> Acc + 1;
            $e -> Acc + 2;
            $i -> Acc + 3;
            $o -> Acc + 4;
            $u -> Acc + 5;
            _ -> Acc
        end
    end, 0, S).