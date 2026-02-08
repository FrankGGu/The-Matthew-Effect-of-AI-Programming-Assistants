-module(find_closest_palindrome).
-export([nearest_palindrome/1]).

nearest_palindrome(N) ->
    Str = integer_to_list(N),
    Len = length(Str),
    Candidates = generate_candidates(Str),
    lists:foldl(fun(Candidate, Acc) ->
        case is_palindrome(Candidate) of
            true ->
                if
                    Candidate == N -> Acc;
                    true ->
                        case abs(Candidate - N) < abs(Acc - N) of
                            true -> Candidate;
                            false -> Acc
                        end
                end;
            false -> Acc
        end
    end, N, Candidates).

generate_candidates(Str) ->
    Len = length(Str),
    Mid = (Len + 1) div 2,
    Prefix = list_to_integer(lists:sublist(Str, Mid)),
    Candidates = [],
    Candidates1 = [Prefix - 1, Prefix, Prefix + 1],
    lists:map(fun(P) ->
        S = integer_to_list(P),
        if
            Len == 1 -> [P];
            true ->
                Left = S,
                Right = lists:reverse(S),
                if
                    Len rem 2 == 0 ->
                        lists:append(Left, Right);
                    true ->
                        lists:append(Left, lists:tl(Right))
                end
        end
    end, Candidates1).

is_palindrome(N) ->
    Str = integer_to_list(N),
    lists:reverse(Str) == Str.