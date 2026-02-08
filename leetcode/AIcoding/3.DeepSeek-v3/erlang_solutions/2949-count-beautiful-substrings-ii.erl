-spec count_beautiful_substrings(S :: unicode:unicode_binary(), K :: integer()) -> integer().
count_beautiful_substrings(S, K) ->
    S1 = binary_to_list(S),
    N = length(S1),
    Vowels = sets:from_list("aeiou"),
    Prefix = lists:foldl(fun(Char, Acc) ->
        case sets:is_element(Char, Vowels) of
            true -> Acc + 1;
            false -> Acc
        end
    end, 0, S1),
    PrefixList = [0 | lists:foldl(fun(Char, [H|T]) ->
        case sets:is_element(Char, Vowels) of
            true -> [H+1 | T];
            false -> [H | T]
        end
    end, [], S1)],
    PrefixList1 = lists:reverse(PrefixList),
    Count = 0,
    Map = #{},
    {Ans, _} = lists:foldl(fun(I, {Cnt, M}) ->
        V = PrefixList1[I+1],
        C = (I - V) * K,
        Key = {V rem K, C rem K},
        case maps:get(Key, M, undefined) of
            undefined -> 
                {Cnt, maps:put(Key, 1, M)};
            Val -> 
                {Cnt + Val, maps:put(Key, Val + 1, M)}
        end
    end, {Count, Map}, lists:seq(0, N)),
    Ans.