-module(solution).
-export([lexicographically_smallest_string/1]).

lexicographically_smallest_string(S) ->
    lex_smallest(list_to_binary(S)).

lex_smallest(S) ->
    case length(S) of
        0 -> <<>>;
        1 -> S;
        _ ->
            case binary:at(S, 0) < binary:at(S, 1) of
                true -> lex_smallest(binary:part(S, 1, length(S) - 1));
                false -> lex_smallest(binary:part(S, 0, length(S) - 1))
            end
    end.