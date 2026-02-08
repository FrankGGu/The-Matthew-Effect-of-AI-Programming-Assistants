-module(solution).
-export([number_of_text_abbreviations/1]).

number_of_text_abbreviations(S) ->
    number_of_text_abbreviations(S, 0, 0, 0, 0).

number_of_text_abbreviations([], _, _, _, Acc) ->
    Acc;
number_of_text_abbreviations([H | T], Pos, Count, Last, Acc) ->
    case H of
        $A -> 
            if Pos == 0 -> number_of_text_abbreviations(T, Pos + 1, Count + 1, 0, Acc);
               true -> number_of_text_abbreviations(T, Pos + 1, Count + 1, 0, Acc)
            end;
        $B -> 
            if Pos == 0 -> number_of_text_abbreviations(T, Pos + 1, Count + 1, 0, Acc);
               true -> number_of_text_abbreviations(T, Pos + 1, Count + 1, 0, Acc)
            end;
        $C -> 
            if Pos == 0 -> number_of_text_abbreviations(T, Pos + 1, Count + 1, 0, Acc);
               true -> number_of_text_abbreviations(T, Pos + 1, Count + 1, 0, Acc)
            end;
        $D -> 
            if Pos == 0 -> number_of_text_abbreviations(T, Pos + 1, Count + 1, 0, Acc);
               true -> number_of_text_abbreviations(T, Pos + 1, Count + 1, 0, Acc)
            end;
        $E -> 
            if Pos == 0 -> number_of_text_abbreviations(T, Pos + 1, Count + 1, 0, Acc);
               true -> number_of_text_abbreviations(T, Pos + 1, Count + 1, 0, Acc)
            end;
        $F -> 
            if Pos == 0 -> number_of_text_abbreviations(T, Pos + 1, Count + 1, 0, Acc);
               true -> number_of_text_abbreviations(T, Pos + 1, Count + 1, 0, Acc)
            end;
        $G -> 
            if Pos == 0 -> number_of_text_abbreviations(T, Pos + 1, Count + 1, 0, Acc);
               true -> number_of_text_abbreviations(T, Pos + 1, Count + 1, 0, Acc)
            end;
        $H -> 
            if Pos == 0 -> number_of_text_abbreviations(T, Pos + 1, Count + 1, 0, Acc);
               true -> number_of_text_abbreviations(T, Pos + 1, Count + 1, 0, Acc)
            end;
        $I -> 
            if Pos == 0 -> number_of_text_abbreviations(T, Pos + 1, Count + 1, 0, Acc);
               true -> number_of_text_abbreviations(T, Pos + 1, Count + 1, 0, Acc)
            end;
        $J -> 
            if Pos == 0 -> number_of_text_abbreviations(T, Pos + 1, Count + 1, 0, Acc);
               true -> number_of_text_abbreviations(T, Pos + 1, Count + 1, 0, Acc)
            end;
        $K -> 
            if Pos == 0 -> number_of_text_abbreviations(T, Pos + 1, Count + 1, 0, Acc);
               true -> number_of_text_abbreviations(T, Pos + 1, Count + 1, 0, Acc)
            end;
        $L -> 
            if Pos == 0 -> number_of_text_abbreviations(T, Pos + 1, Count + 1, 0, Acc);
               true -> number_of_text_abbreviations(T, Pos + 1, Count + 1, 0, Acc)
            end;
        $M -> 
            if Pos == 0 -> number_of_text_abbreviations(T, Pos + 1, Count + 1, 0, Acc);
               true -> number_of_text_abbreviations(T, Pos + 1, Count + 1, 0, Acc)
            end;
        $N -> 
            if Pos == 0 -> number_of_text_abbreviations(T, Pos + 1, Count + 1, 0, Acc);
               true -> number_of_text_abbreviations(T, Pos + 1, Count + 1, 0, Acc)
            end;
        $O -> 
            if Pos == 0 -> number_of_text_abbreviations(T, Pos + 1, Count + 1, 0, Acc);
               true -> number_of_text_abbreviations(T, Pos + 1, Count + 1, 0, Acc)
            end;
        $P -> 
            if Pos == 0 -> number_of_text_abbreviations(T, Pos + 1, Count + 1, 0, Acc);
               true -> number_of_text_abbreviations(T, Pos + 1, Count + 1, 0, Acc)
            end;
        $Q -> 
            if Pos == 0 -> number_of_text_abbreviations(T, Pos + 1, Count + 1, 0, Acc);
               true -> number_of_text_abbreviations(T, Pos + 1, Count + 1, 0, Acc)
            end;
        $R -> 
            if Pos == 0 -> number_of_text_abbreviations(T, Pos + 1, Count + 1, 0, Acc);
               true -> number_of_text_abbreviations(T, Pos + 1, Count + 1, 0, Acc)
            end;
        $S -> 
            if Pos == 0 -> number_of_text_abbreviations(T, Pos + 1, Count + 1, 0, Acc);
               true -> number_of_text_abbreviations(T, Pos + 1, Count + 1, 0, Acc)
            end;
        $T -> 
            if Pos == 0 -> number_of_text_abbreviations(T, Pos + 1, Count + 1, 0, Acc);
               true -> number_of_text_abbreviations(T, Pos + 1, Count + 1, 0, Acc)
            end;
        $U -> 
            if Pos == 0 -> number_of_text_abbreviations(T, Pos + 1, Count + 1, 0, Acc);
               true -> number_of_text_abbreviations(T, Pos + 1, Count + 1, 0, Acc)
            end;
        $V -> 
            if Pos == 0 -> number_of_text_abbreviations(T, Pos + 1, Count + 1, 0, Acc);
               true -> number_of_text_abbreviations(T, Pos + 1, Count + 1, 0, Acc)
            end;
        $W -> 
            if Pos == 0 -> number_of_text_abbreviations(T, Pos + 1, Count + 1, 0, Acc);
               true -> number_of_text_abbreviations(T, Pos + 1, Count + 1, 0, Acc)
            end;
        $X -> 
            if Pos == 0 -> number_of_text_abbreviations(T, Pos + 1, Count + 1, 0, Acc);
               true -> number_of_text_abbreviations(T, Pos + 1, Count + 1, 0, Acc)
            end;
        $Y -> 
            if Pos == 0 -> number_of_text_abbreviations(T, Pos + 1, Count + 1, 0, Acc);
               true -> number_of_text_abbreviations(T, Pos + 1, Count + 1, 0, Acc)
            end;
        $Z -> 
            if Pos == 0 -> number_of_text_abbreviations(T, Pos + 1, Count + 1, 0, Acc);
               true -> number_of_text_abbreviations(T, Pos + 1, Count + 1, 0, Acc)
            end;
        _ -> number_of_text_abbreviations(T, Pos + 1, Count, 0, Acc)
    end.