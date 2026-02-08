-module(solution).
-export([rotate_string/2]).

rotate_string(A, B) ->
    A_len = string:length(A),
    B_len = string:length(B),
    if
        A_len /= B_len -> false;
        A =:= "" -> B =:= "";
        true -> string:find(string:concat(A, A), B) > 0
    end.