-module(minimum_array_end).
-export([min_array_end/2]).

min_array_end(A, B) ->
    N = length(A),
    M = length(B),
    I = 0,
    J = 0,
    Result = array:new(N + M),
    min_array_end(A, B, I, J, Result).

min_array_end([], [], _, _, Result) ->
    Result;
min_array_end([], B, _, J, Result) ->
    min_array_end([], B, 0, J, Result);
min_array_end(A, [], I, _, Result) ->
    min_array_end(A, [], I, 0, Result);
min_array_end([AHead | ATail], [BHead | BTail], I, J, Result) ->
    if
        AHead < BHead ->
            array:set(I, AHead, Result),
            min_array_end(ATail, B, I + 1, J, Result);
        true ->
            array:set(J, BHead, Result),
            min_array_end(A, BTail, I, J + 1, Result)
    end.