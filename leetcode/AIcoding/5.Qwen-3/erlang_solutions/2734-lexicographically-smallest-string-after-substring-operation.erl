-module(solution).
-export([lexicographically_smallest_string/1]).

lexicographically_smallest_string(S) ->
    lex_smallest(S, 0, length(S) - 1).

lex_smallest(S, I, J) when I >= J -> S;
lex_smallest(S, I, J) ->
    case string:sub(S, I+1, J+1) of
        Sub when Sub == lists:reverse(Sub) -> 
            case string:sub(S, I+1, J) of
                Sub2 when Sub2 == lists:reverse(Sub2) -> 
                    case string:sub(S, I, J) of
                        Sub3 when Sub3 == lists:reverse(Sub3) -> 
                            S;
                        _ -> 
                            lex_smallest(S, I+1, J)
                    end;
                _ -> 
                    lex_smallest(S, I+1, J)
            end;
        _ -> 
            lex_smallest(S, I+1, J)
    end.