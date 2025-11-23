-module(solution).
-export([nearest_palindromic/1]).

nearest_palindromic(N) ->
    Candidates = [next_palindrome(P) || P <- [N, dec(N), inc(N)]] ++ [higher_palindrome(P) || P <- [N, dec(N), inc(N)]],
    {_, Closest} = lists:foldl(fun(Candidate, {Diff, Closest}) ->
        case abs(list_to_integer(N) - list_to_integer(Candidate)) of
            D when D < Diff -> {D, Candidate};
            _ -> {Diff, Closest}
        end
    end, {infinity, ""}, lists:uniq(Candidates)),
    Closest.

next_palindrome(N) ->
    Str = list_to_binary(N),
    Palindrome = binary_to_list(Str),
    lists:reverse(Palindrome).

dec(N) ->
    lists:flatten(io_lib:format("~B", [list_to_integer(N) - 1])).

inc(N) ->
    lists:flatten(io_lib:format("~B", [list_to_integer(N) + 1])).

higher_palindrome(N) ->
    Len = length(N),
    Prefix = lists:sublist(N, 1, (Len + 1) div 2),
    if
        Len rem 2 == 0 ->
            lists:flatten(Prefix ++ lists:reverse(Prefix));
        true ->
            lists:flatten(Prefix ++ tl(lists:reverse(Prefix)))
    end.