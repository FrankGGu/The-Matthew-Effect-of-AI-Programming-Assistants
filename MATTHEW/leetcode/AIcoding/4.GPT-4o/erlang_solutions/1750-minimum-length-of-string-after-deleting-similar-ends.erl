-module(solution).
-export([minimum_length/1]).

minimum_length(S) ->
    Length = string:length(S),
    if 
        Length == 0 -> 0;
        true -> remove_similar_ends(S, Length)
    end.

remove_similar_ends(S, Length) ->
    FirstChar = string:substr(S, 1, 1),
    LastChar = string:substr(S, Length, 1),
    case (FirstChar == LastChar) of
        true -> 
            remove_similar_ends(string:substr(S, 2, Length - 2), Length - 2);
        false -> Length
    end.