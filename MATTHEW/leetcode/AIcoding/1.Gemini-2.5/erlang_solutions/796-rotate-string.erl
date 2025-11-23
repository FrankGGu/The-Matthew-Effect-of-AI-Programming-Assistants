-module(solution).
-export([rotate_string/2]).

rotate_string(A, B) when length(A) =/= length(B) ->
    false;
rotate_string(A, B) when A == B ->
    true;
rotate_string(A, B) ->
    DoubleA = A ++ A,
    case string:str(DoubleA, B) of
        0 -> false;
        _ -> true
    end.