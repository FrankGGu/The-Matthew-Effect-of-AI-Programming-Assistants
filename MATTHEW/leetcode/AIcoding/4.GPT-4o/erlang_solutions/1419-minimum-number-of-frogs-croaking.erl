-module(solution).
-export([min_frogs/1]).

min_frogs(S) ->
    min_frogs(S, 0, 0, 0).

min_frogs([], 0, 0, _) -> 
    0;
min_frogs([], _, _, _) -> 
    -1;
min_frogs([H|T], Count, CroakCount, Current) ->
    case H of
        $c -> 
            min_frogs(T, Count + 1, CroakCount + 1, Current + 1);
        $r -> 
            case CroakCount of
                0 -> -1;
                _ -> min_frogs(T, Count, CroakCount - 1, Current);
            end;
        $o -> 
            case Current of
                0 -> -1;
                _ -> min_frogs(T, Count, CroakCount, Current);
            end;
        $a -> 
            case Current of
                0 -> -1;
                _ -> min_frogs(T, Count, CroakCount, Current);
            end;
        $k -> 
            case Current of
                1 -> min_frogs(T, Count - 1, CroakCount, Current - 1);
                _ -> -1;
            end
    end.