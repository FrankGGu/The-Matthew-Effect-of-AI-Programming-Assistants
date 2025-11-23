-module(solution).
-export([num_distinct_echo_substrings/1]).

num_distinct_echo_substrings(S) ->
    N = length(S),
    Set = sets:new(),
    EchoSet = echo_substrings(S, N, 0, Set),
    sets:size(EchoSet).

echo_substrings(_, _, N, Set) when N >= length(S) ->
    Set;
echo_substrings(S, N, Start, Set) ->
    Len = N - Start,
    if
        Len < 2 ->
            echo_substrings(S, N + 1, Start, Set);
        true ->
            Sub = lists:sublist(S, Start + 1, Len),
            Sub2 = lists:sublist(S, Start + Len + 1, Len),
            if
                Sub == Sub2 ->
                    NewSet = sets:add_element(Sub, Set),
                    echo_substrings(S, N + 1, Start, NewSet);
                true ->
                    echo_substrings(S, N + 1, Start, Set)
            end
    end.

echo_substrings(S, N, Start, Set) ->
    case Start + N + 1 <= length(S) of
        true ->
            echo_substrings(S, N, Start + 1, Set);
        false ->
            echo_substrings(S, N + 1, 0, Set)
    end.