-module(solution).
-export([max_num_of_substrings/1]).

max_num_of_substrings(S) ->
    Length = string:length(S),
    {Left, Right} = find_bounds(S, Length, {[], []}),
    lists:filter(fun({L, R}) -> L =< R end, lists:zip(Left, Right)).

find_bounds(S, Length, {LeftAcc, RightAcc}) ->
    case Length of
        0 -> {lists:reverse(LeftAcc), lists:reverse(RightAcc)};
        _ ->
            {L, R} = find_substring_bounds(S, Length),
            find_bounds(string:substr(S, 1, Length - 1), Length - 1, { [L | LeftAcc], [R | RightAcc] })
    end.

find_substring_bounds(S, Length) ->
    {lists:foldl(fun(C, {L, R}) ->
        {min(L, string:find(S, <<C>>, 1)), max(R, string:find(S, <<C>>, 1) + string:length(S))}
    end, {Length, 0}, string:to_list(S))}.