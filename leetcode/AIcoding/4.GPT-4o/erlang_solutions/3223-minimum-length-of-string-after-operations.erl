-module(solution).
-export([minimum_length/1]).

minimum_length(S) ->
    minimum_length_helper(S, []).

minimum_length_helper([], Acc) ->
    length(Acc);
minimum_length_helper([H | T], Acc) ->
    case Acc of
        [] -> minimum_length_helper(T, [H]);
        [H2 | _] when H =:= H2 -> minimum_length_helper(T, tl(Acc));
        _ -> minimum_length_helper(T, [H | Acc])
    end.