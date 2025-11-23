-module(solution).
-export([gcdOfStrings/2]).

gcdOfStrings(A, B) ->
    case {A, B} of
        {"", ""} -> "";
        {A, ""} -> A;
        {"", B} -> B;
        {A, B} -> 
            if
                A =:= B -> A;
                string:substr(A, 0, string:length(B)) =:= B -> gcdOfStrings(A, string:substr(A, string:length(B), string:length(A) - string:length(B)));
                string:substr(B, 0, string:length(A)) =:= A -> gcdOfStrings(string:substr(B, string:length(A), string:length(B) - string:length(A)), B);
                true -> ""
            end
    end.