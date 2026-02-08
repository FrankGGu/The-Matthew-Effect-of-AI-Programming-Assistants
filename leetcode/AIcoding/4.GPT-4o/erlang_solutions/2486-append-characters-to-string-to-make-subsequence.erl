-module(solution).
-export([add_minimum/2]).

add_minimum(S, T) ->
    SLen = string:len(S),
    TLen = string:len(T),
    add_minimum(S, T, SLen, TLen, 0).

add_minimum(_, [], _, TLen, Acc) -> 
    TLen + Acc;
add_minimum([], _, SLen, _, Acc) -> 
    SLen + Acc;
add_minimum([SChar | SRest], [TChar | TRest], SLen, TLen, Acc) ->
    case Schar == TChar of
        true -> 
            add_minimum(SRest, TRest, SLen - 1, TLen - 1, Acc);
        false -> 
            add_minimum(SRest, [TChar | TRest], SLen - 1, TLen, Acc + 1)
    end.