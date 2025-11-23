-module(longest_chunked_palindrome_decomposition).
-export([longestDecomposition/1]).

longestDecomposition(S) ->
    longestDecomposition(S, 0, 0, []).

longestDecomposition([], _, _, Acc) ->
    length(Acc);
longestDecomposition(S, Left, Right, Acc) ->
    case string:substr(S, 1, Left) of
        string:substr(S, Right + 1, Left) ->
            longestDecomposition(string:substr(S, Left + 1), 0, 0, [Acc | []]);
        _ ->
            case Left < Right of
                true ->
                    longestDecomposition(S, Left + 1, Right, Acc);
                false ->
                    longestDecomposition(string:substr(S, Right + 1), 0, 0, [Acc | []])
            end
    end.