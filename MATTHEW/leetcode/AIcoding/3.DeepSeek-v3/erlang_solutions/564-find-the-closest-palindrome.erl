-spec nearest_palindromic(N :: unicode:unicode_binary()) -> unicode:unicode_binary().
nearest_palindromic(N) ->
    Num = binary_to_integer(N),
    if
        Num =< 10 -> integer_to_binary(Num - 1);
        true ->
            Candidates = generate_candidates(N),
            find_closest(Num, Candidates)
    end.

generate_candidates(N) ->
    Num = binary_to_integer(N),
    Len = byte_size(N),
    Half = (Len + 1) div 2,
    Prefix = binary_part(N, 0, Half),
    PrefixNum = binary_to_integer(Prefix),
    Candidates = [],
    Candidates1 = add_candidate(Candidates, PrefixNum - 1, Len),
    Candidates2 = add_candidate(Candidates1, PrefixNum, Len),
    Candidates3 = add_candidate(Candidates2, PrefixNum + 1, Len),
    Candidates4 = add_candidate(Candidates3, round(math:pow(10, Len - 1)) - 1, Len),
    Candidates5 = add_candidate(Candidates4, round(math:pow(10, Len)) + 1, Len),
    lists:filter(fun(X) -> X /= Num end, Candidates5).

add_candidate(Candidates, Prefix, Len) ->
    Str = integer_to_list(Prefix),
    Rev = case Len rem 2 of
        0 -> lists:reverse(Str);
        1 -> lists:reverse(tl(Str))
    end,
    Pal = list_to_integer(Str ++ Rev),
    [Pal | Candidates].

find_closest(Num, [H | T]) ->
    find_closest(Num, T, H, abs(Num - H)).

find_closest(_, [], Best, _) -> integer_to_binary(Best);
find_closest(Num, [H | T], Best, BestDiff) ->
    Diff = abs(Num - H),
    if
        Diff < BestDiff -> find_closest(Num, T, H, Diff);
        Diff == BestDiff andalso H < Best -> find_closest(Num, T, H, Diff);
        true -> find_closest(Num, T, Best, BestDiff)
    end.