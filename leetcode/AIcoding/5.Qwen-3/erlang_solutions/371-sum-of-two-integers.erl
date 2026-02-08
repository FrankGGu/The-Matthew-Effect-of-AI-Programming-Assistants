-module(solution).
-export([get_sum/2]).

get_sum(A, B) ->
    case A of
        0 -> B;
        _ -> get_sum(B, A band B) + (A bxor B)
    end.