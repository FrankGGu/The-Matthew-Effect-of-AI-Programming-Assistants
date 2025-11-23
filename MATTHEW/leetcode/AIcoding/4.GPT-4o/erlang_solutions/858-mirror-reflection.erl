-module(mirror_reflection).
-export([mirror_reflection/3]).

mirror_reflection(p, q) ->
    case (p rem 2) of
        0 -> 
            case (q rem 2) of
                0 -> 0;
                1 -> 2
            end;
        1 -> 
            case (q rem 2) of
                0 -> 1;
                1 -> 3
            end
    end.